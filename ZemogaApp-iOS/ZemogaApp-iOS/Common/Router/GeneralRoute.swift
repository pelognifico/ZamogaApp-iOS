//
//  GeneralRoute.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case postsHome
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .postsHome:
            return PostsHomeViewController()
        }
    }
}
