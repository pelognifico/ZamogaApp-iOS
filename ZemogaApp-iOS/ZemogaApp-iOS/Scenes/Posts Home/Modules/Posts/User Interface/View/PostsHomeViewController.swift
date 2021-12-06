//
//  PostsHomeViewController.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import UIKit

protocol PostsHomeDisplayLogic: AnyObject {
    func displayPosts(viewModel: PostsHomeModel.Posts.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue)
}

class PostsHomeViewController: BaseViewController {
    
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var optionsSegmentedControl: UISegmentedControl!
    
    let cellPostsNibName = "PostsHomeTableViewCell"
    
    var posts : [PostsHomeModel.Posts.Response] = []
    
    var isRead: ((PostsHomeModel.Posts.Response) -> Void)?
    
    var showFavorite = false
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(loadInitialData), for: .valueChanged)
        return refreshControl
    }()
    
    var interactor: PostsHomeBusinessLogic?
    var router: (NSObjectProtocol & PostsHomeRoutingLogic & PostsHomeDataPassing)?

    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = PostsHomeInteractor()
        let presenter = PostsHomePresenter()
        let router = PostsHomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsNavBarHome()
        loadInitialData()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        settingTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postsTableView.reloadData()
        
        if posts.count > 0 && ZASettings.current.postFavorites?.count ?? 0 > 0 {
            for i in posts.indices {
                ZASettings.current.postFavorites?.forEach({ j in
                    if posts[i].id == j.id {
                        posts[i].isFavorite = true
                    }
                })
            }
            
            postsTableView.reloadData()
        }
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        
        let request = PostsHomeModel.Posts.Request()
        interactor?.getPosts(request: request)
    }
    
    private func settingTableView() {
        postsTableView.register(UINib(nibName: cellPostsNibName, bundle: nil), forCellReuseIdentifier: PostsHomeTableViewCell.reuseIdentifier)
    }
    
    func settingsNavBarHome() {
        let titleScreen = UILabel()
        let titleScreenView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        userButton = BadgedButtonItem(with: UIImage(named: "reload"))
        
        userButton.tapAction = {
            self.loadInitialData()
        }
        
        navigationController?.clearBackground()
        navigationController?.setBackground()
        
        titleScreen.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        titleScreen.text = "POST"
        titleScreen.font = UIFont(name: "Roboto-Bold", size: 18)
        titleScreen.numberOfLines = 1
        titleScreen.textAlignment = .center
        titleScreen.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        titleScreenView.addSubview(titleScreen)
        titleScreenView.backgroundColor = .clear
        
        navigationItem.titleView = titleScreenView
        navigationItem.rightBarButtonItems = [userButton]
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    //MARK: - Actions
    @IBAction func actionOnclick(_ sender: Any) {
        if optionsSegmentedControl.selectedSegmentIndex == 0 {
            showFavorite = false
            postsTableView.reloadData()
        } else if optionsSegmentedControl.selectedSegmentIndex == 1 {
            showFavorite = true
            postsTableView.reloadData()
        }
    }
    
    @IBAction func deleteAllOnClick(_ sender: Any) {
        posts.removeAll()
        postsTableView.reloadData()
    }
    
}

// MARK: - PostsHomeDisplayLogic
extension PostsHomeViewController: PostsHomeDisplayLogic {
    func displayPosts(viewModel: PostsHomeModel.Posts.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        if viewModel.data.count > 0 {
            posts = viewModel.data
            postsTableView.reloadData()
        }
    }
    
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PostsHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showFavorite ? ZASettings.current.postFavorites?.count ?? 0 : posts.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postsTableView.dequeueReusableCell(withIdentifier: PostsHomeTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? PostsHomeTableViewCell else {
                                                        fatalError()
        }
        
        if let postsCell = showFavorite ? ZASettings.current.postFavorites?[indexPath.row] : posts[indexPath.row] {
            let count = indexPath.row
            if showFavorite {
                cell.configUI(posts: postsCell, state: false, favorite: postsCell.isFavorite)
            } else {
                cell.configUI(posts: postsCell, state: count > 19 ? false : true, favorite: postsCell.isFavorite)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtrl = PostsDetailsViewController()
        viewCtrl.dataDescription = showFavorite ? ZASettings.current.postFavorites?[indexPath.row] : posts[indexPath.row]
        posts[indexPath.row].isSelected = true
        self.navigationController?.pushViewController(viewCtrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts.remove(at: indexPath.row)
            postsTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
