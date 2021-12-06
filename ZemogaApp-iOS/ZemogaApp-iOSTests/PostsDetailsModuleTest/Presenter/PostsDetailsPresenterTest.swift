//
//  PostsDetailsPresenterTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostDetailsPresenterTest: XCTestCase {
    var sut: PostsDetailsPresenter!
    var viewControllerMock: PostsDetailsDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = PostsDetailsDisplayLogicMock()
        sut = PostsDetailsPresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentPostsDetailsSuccess() {
        //Given
        let responseMock = [PostsDetailsModel.Users.Response(id: 1, name: "ABC", email: "ABC", phone: "ABC", website: "ABC")]
        
        let viewModel = PostsDetailsModel.Users.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayUsers(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentUsers(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentPostsHomeFailure() {
        //Given
        let error: PostsHomeError = .request
        let responseMock = PostsHomeModel.Error.Response(error: error)
        let viewModel = PostsHomeModel.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentError(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
}
