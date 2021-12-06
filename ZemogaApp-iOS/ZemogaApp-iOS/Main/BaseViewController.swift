//
//  BaseViewController.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loadingVC: LoadingIndicatorViewController?
    var userButton = BadgedButtonItem(with: UIImage(named: "reload")?.withRenderingMode(.alwaysOriginal))
    var isSelect: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setupBackButton() {
        let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(self.backButtonClickedDismiss(sender:)))
        
        self.navigationItem.leftBarButtonItem  = backButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @objc func backButtonClickedDismiss(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Loading View
extension BaseViewController {
    func showLoading() {
        loadingVC = LoadingIndicatorViewController()
        add(loadingVC!)
        loadingVC?.view.frame = view.bounds
    }

    func showLoading(inside wiew: UIView) {
        loadingVC = LoadingIndicatorViewController()
        add(child: loadingVC!, container: wiew)
        loadingVC?.view.frame = wiew.bounds
    }

    func hideLoading() {
        loadingVC?.remove()
        loadingVC = nil
    }
}


// MARK: - Alert
extension BaseViewController {
    func displaySimpleAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

