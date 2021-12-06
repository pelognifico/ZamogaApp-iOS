//
//  PostsHomeWorkerMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import Foundation
@testable import ZemogaApp_iOS

class PostsHomeWorkerMock : PostsServiceProtocol {
    
    var resultGetPosts: (Result<[PostsHomeModel.Posts.Response], PostsHomeError>)?
    var resultGetUsers: (Result<[PostsDetailsModel.Users.Response], PostsHomeError>)?
    
    var isFunctionWasCalled = false
    
    func getPosts(request: PostsHomeModel.Posts.Request, completion: @escaping (Result<[PostsHomeModel.Posts.Response], PostsHomeError>) -> Void) {
        if let result = resultGetPosts {
            isFunctionWasCalled = true
            completion(result)
        }
    }
    
    func getUsers(request: PostsDetailsModel.Users.Request, completion: @escaping (Result<[PostsDetailsModel.Users.Response], PostsHomeError>) -> Void) {
        if let result = resultGetUsers {
            isFunctionWasCalled = true
            completion(result)
        }
    }
}
