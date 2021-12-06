//
//  PostsDetailsRouter.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 3/12/21.
//

import Foundation

@objc protocol PostsDetailsRoutingLogic {
}

protocol PostsDetailsDataPassing {
    var dataStore: PostsDetailsDataStore? { get }
}

class PostsDetailsRouter: NSObject, PostsDetailsRoutingLogic, PostsDetailsDataPassing {
    weak var viewController: PostsDetailsViewController?
    var dataStore: PostsDetailsDataStore?
}
