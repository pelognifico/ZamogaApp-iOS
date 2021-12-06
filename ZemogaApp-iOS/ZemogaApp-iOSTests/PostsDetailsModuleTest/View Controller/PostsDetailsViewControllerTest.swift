//
//  PostsDetailsViewControllerTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsDetailsViewControllerTest: XCTestCase {
    var sut: PostsDetailsViewController!
    var viewControllerMock: PostsDetailsDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = PostsDetailsDisplayLogicMock()
        sut = PostsDetailsViewController()
    }
    
    //MARK: -- GetPosts
    func testGetUsers() {
        //Given
        let responseMock = [PostsDetailsModel.Users.Response(id: 1, name: "ABC", email: "ABC", phone: "ABC", website: "ABC")]
        
        let viewModel = PostsDetailsModel.Users.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayUsers(viewModel: viewModel, on: queue)
        
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
