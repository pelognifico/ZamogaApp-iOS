//
//  PostsDetailsPresenter.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 3/12/21.
//


import UIKit

protocol PostsDetailsPresentationLogic {
    func presentUsers(response: [PostsDetailsModel.Users.Response])
    func presentError(response: PostsHomeModel.Error.Response)
}

class PostsDetailsPresenter: PostsDetailsPresentationLogic {
    
    weak var viewController: PostsDetailsDisplayLogic?
    
    // MARK: - Present Users
    func presentUsers(response: [PostsDetailsModel.Users.Response]) {
        let viewModel = PostsDetailsModel.Users.ViewModel(data: response)
        viewController?.displayUsers(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Error
    func presentError(response: PostsHomeModel.Error.Response) {
        let viewModel = PostsHomeModel.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
