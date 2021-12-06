//
//  PostsWorker.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import Foundation

protocol PostsServiceProtocol {
    func getPosts(request: PostsHomeModel.Posts.Request, completion: @escaping (Result<[PostsHomeModel.Posts.Response], PostsHomeError>) -> Void)
    func getUsers(request: PostsDetailsModel.Users.Request, completion: @escaping (Result<[PostsDetailsModel.Users.Response], PostsHomeError>) -> Void)
}

class PostsWorker: PostsServiceProtocol{
    var postsService: PostsServiceProtocol
    
    init(postsService: PostsServiceProtocol = PostsAPI()) {
        self.postsService = postsService
    }
    
    func getPosts(request: PostsHomeModel.Posts.Request, completion: @escaping (Result<[PostsHomeModel.Posts.Response], PostsHomeError>) -> Void) {
        postsService.getPosts(request: request, completion: { result in
            completion(result)
        })
    }
    
    func getUsers(request: PostsDetailsModel.Users.Request, completion: @escaping (Result<[PostsDetailsModel.Users.Response], PostsHomeError>) -> Void) {
        postsService.getUsers(request: request, completion: { result in
            completion(result)
        })
    }
}
