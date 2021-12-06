//
//  Helper.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import Foundation
import UIKit

struct Helper {
    static func presentFavoriteModal(vc: UIViewController, description: String, completationOk : (() -> Void)? = nil, completationCancel : (() -> Void)? = nil){

        let storyboard = UIStoryboard(name: "ZAModal", bundle: nil)
        if let modal = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as? ModalViewController {
            
            modal.modalPresentationStyle   = .overCurrentContext
            modal.titleText                = description
            modal.completationOk           = completationOk
            modal.completationCancel       = completationCancel

            vc.present(modal, animated: false, completion: nil)
        }
    }
}

