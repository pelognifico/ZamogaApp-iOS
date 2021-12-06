//
//  ModalViewController.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 5/12/21.
//

import UIKit

class ModalViewController: UIViewController {

    @IBOutlet weak var titleModalLabel: UILabel!
    @IBOutlet weak var descriptionModalLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    var titleText : String?
    var message : String?
    
    var completationOk : (() -> Void)?
    var completationCancel : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
        self.animation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.dismiss(animated: false)
    }
    
    //MARK: -Methods
    func configUI(){
        
        let radius : CGFloat = 25.0
        self.containerView?.clipsToBounds = true
        self.containerView?.layer.cornerRadius = radius
        
        self.titleModalLabel?.text  = self.titleText
        
        if self.titleText == nil {
            self.titleModalLabel?.isHidden = true
            self.titleHeightConstraint?.constant = 0
        }
        
        self.titleModalLabel?.adjustsFontSizeToFitWidth = true
        self.descriptionModalLabel?.text  = self.message
        self.descriptionModalLabel?.textColor = .gray
        self.acceptButton?.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func animation(){
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.descriptionModalLabel?.transform  = CGAffineTransform(scaleX: 0.6, y: 0.6)
                        self.containerView?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.2) {
                            self.descriptionModalLabel?.transform  = CGAffineTransform.identity
                            self.containerView?.transform = CGAffineTransform.identity
                        }
        })
    }
    
    // MARK: -Actions
    @IBAction func acceptOnClick(_ sender: Any) {
        self.dismiss(animated: false)
        self.completationOk?()
    }
    
    @IBAction func cancelOnClick(_ sender: Any) {
        self.dismiss(animated: false)
        self.completationCancel?()
    }
    
}
