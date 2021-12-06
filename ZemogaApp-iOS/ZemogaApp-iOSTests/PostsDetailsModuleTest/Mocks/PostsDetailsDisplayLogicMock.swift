//
//  PostsDetailsDisplayLogicMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import Foundation
@testable import ZemogaApp_iOS

final class PostsDetailsDisplayLogicMock: PostsDetailsDisplayLogic {
    var viewModelDisplayUsers: PostsDetailsModel.Users.ViewModel?

    var isFunctionWasCalled = false
    
    func displayUsers(viewModel: PostsDetailsModel.Users.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
