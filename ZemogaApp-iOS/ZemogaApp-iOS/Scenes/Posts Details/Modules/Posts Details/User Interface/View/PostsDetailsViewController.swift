//
//  PostsDetailsViewController.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 3/12/21.
//

import UIKit

protocol PostsDetailsDisplayLogic: AnyObject {
    func displayUsers(viewModel: PostsDetailsModel.Users.ViewModel, on queu: DispatchQueue)
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue)
}

class PostsDetailsViewController: BaseViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    var dataDescription: PostsHomeModel.Posts.Response?
    var dataUser: [PostsDetailsModel.Users.Response]?
    var userId: Int?
    
    var isReadCell: ((PostsHomeModel.Posts.Response) -> Void)?
    
    var interactor: PostsDetailsBusinessLogic?
    var router: (NSObjectProtocol & PostsDetailsRoutingLogic & PostsDetailsDataPassing)?

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
        let interactor = PostsDetailsInteractor()
        let presenter = PostsDetailsPresenter()
        let router = PostsDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackButton()
        settingsNavBarDetail()
        loadInitialData()
    }
    
    // MARK: - Methods
    @objc func loadInitialData() {
        showLoading()
        
        let request = PostsDetailsModel.Users.Request()
        interactor?.getUsers(request: request)
    }
    
    func settingsNavBarDetail() {
        let titleScreen = UILabel()
        let titleScreenView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        userButton = BadgedButtonItem(with: UIImage(named: "favorite"))
        
        userButton.tapAction = {
            if let dataPost = self.dataDescription {
                Helper.presentFavoriteModal(vc: self, description: "Add to Favorites") {
                    ZASettings.current.postFavorites?.append(dataPost)
                } completationCancel: {
                    print("Cancel")
                }
            }
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
}

// MARK: - PostsDetailsDisplayLogic
extension PostsDetailsViewController: PostsDetailsDisplayLogic {
    func displayUsers(viewModel: PostsDetailsModel.Users.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        
        if viewModel.data.count > 0 {
            dataUser = viewModel.data
            descriptionLabel.text = dataDescription?.body
            userId = dataDescription?.userId
            
            dataUser?.forEach({ i in
                if userId == i.id {
                    nameLabel.text = i.name
                    emailLabel.text = i.email
                    phoneLabel.text = i.phone
                    websiteLabel.text = i.website
                }
            })
        }
    }
    
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue = .main) {
        hideLoading()
        displaySimpleAlert(with: "Error", message: viewModel.error.description)
    }
    
}
