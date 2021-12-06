//
//  PostsHomeRouter.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import Foundation

@objc protocol PostsHomeRoutingLogic {
}

protocol PostsHomeDataPassing {
    var dataStore: PostsHomeDataStore? { get }
}

class PostsHomeRouter: NSObject, PostsHomeRoutingLogic, PostsHomeDataPassing {
    weak var viewController: PostsHomeViewController?
    var dataStore: PostsHomeDataStore?
  
}

