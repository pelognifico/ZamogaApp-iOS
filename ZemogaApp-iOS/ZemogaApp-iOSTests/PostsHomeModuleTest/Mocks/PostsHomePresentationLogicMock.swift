//
//  PostsHomePresentationLogicMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import Foundation
@testable import ZemogaApp_iOS

final class PostsHomePresentationLogicMock: PostsHomePresentationLogic {
    var responsePosts: [PostsHomeModel.Posts.Response]?
    var isFunctionWasCalled = false
    
    func presentPosts(response: [PostsHomeModel.Posts.Response]) {
        if responsePosts != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: PostsHomeModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
