//
//  PostsHomeViewControllerTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsHomeViewControllerTest: XCTestCase {
    var sut: PostsHomeViewController!
    var viewControllerMock: PostsHomeDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = PostsHomeDisplayLogicMock()
        sut = PostsHomeViewController()
    }
    
    //MARK: -- GetPosts
    func testGetPosts() {
        //Given
        let responseMock = [PostsHomeModel.Posts.Response(userId: 1, id: 1, title: "ABC", body: "ABC")]
        
        let viewModel = PostsHomeModel.Posts.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayPosts(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.loadInitialData()
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    //MARK: -- GetPostsFailure
    func testFailure() {
        //Given
        let error: PostsHomeError = .request
        let viewModel = PostsHomeModel.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.displayError(viewModel: viewModel, on: queue)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
}
