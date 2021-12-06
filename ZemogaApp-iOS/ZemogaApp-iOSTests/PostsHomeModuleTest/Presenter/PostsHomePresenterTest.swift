//
//  PostsHomePresenterTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostHomePresenterTest: XCTestCase {
    var sut: PostsHomePresenter!
    var viewControllerMock: PostsHomeDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = PostsHomeDisplayLogicMock()
        sut = PostsHomePresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentPostsHomeSuccess() {
        //Given
        let responseMock = [PostsHomeModel.Posts.Response(userId: 1, id: 1, title: "ABC", body: "ABC")]
        
        let viewModel = PostsHomeModel.Posts.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayPosts(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentPosts(response: responseMock)
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
