//
//  PostsDetailsInteractor.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 3/12/21.
//

import UIKit

protocol PostsDetailsBusinessLogic {
    func getUsers(request: PostsDetailsModel.Users.Request)
}

protocol PostsDetailsDataStore {
}

class PostsDetailsInteractor: PostsDetailsBusinessLogic, PostsDetailsDataStore {
    
    var presenter: PostsDetailsPresentationLogic?
    
    var worker: PostsServiceProtocol
    
    init(worker: PostsServiceProtocol = PostsWorker()) {
        self.worker = worker
    }
    
    // MARK: - Methods
    func getUsers(request: PostsDetailsModel.Users.Request) {
        worker.getUsers(request: request, completion: { result in
            switch result {
            case .success(let response):
                self.presenter?.presentUsers(response: response)
            case .failure(let error):
                let response = PostsHomeModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        })
    }

}
