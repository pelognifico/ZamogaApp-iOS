//
//  PostsHomeDisplayLogicMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import Foundation
@testable import ZemogaApp_iOS

final class PostsHomeDisplayLogicMock: PostsHomeDisplayLogic {
    var viewModelDisplayPosts: PostsHomeModel.Posts.ViewModel?

    var isFunctionWasCalled = false
    
    func displayPosts(viewModel: PostsHomeModel.Posts.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
