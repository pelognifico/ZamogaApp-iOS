//
//  PostsHomeInteractor.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import UIKit

protocol PostsHomeBusinessLogic {
    func getPosts(request: PostsHomeModel.Posts.Request)
}

protocol PostsHomeDataStore {
}

class PostsHomeInteractor: PostsHomeBusinessLogic, PostsHomeDataStore {
    
    var presenter: PostsHomePresentationLogic?
    
    var worker: PostsServiceProtocol
    
    init(worker: PostsServiceProtocol = PostsWorker()) {
        self.worker = worker
    }
    
    // MARK: - Methods
    func getPosts(request: PostsHomeModel.Posts.Request) {
        worker.getPosts(request: request, completion: { result in
            switch result {
            case .success(let response):
                self.presenter?.presentPosts(response: response)
            case .failure(let error):
                let response = PostsHomeModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        })
    }

}
