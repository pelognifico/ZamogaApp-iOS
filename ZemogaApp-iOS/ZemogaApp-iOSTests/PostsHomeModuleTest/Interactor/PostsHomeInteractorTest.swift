//
//  PostsHomeInteractorTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsHomeInteractorTest: XCTestCase {
    var sut: PostsHomeInteractor!
    var postsHomePresenterMock: PostsHomeWorkerMock!

    override func setUp() {
        postsHomePresenterMock = PostsHomeWorkerMock()
        sut = PostsHomeInteractor(worker: postsHomePresenterMock)
    }

    func testPostsHomeSuccess() {
        //Given
        let requestData = PostsHomeModel.Posts.Request()
        let responseMock = [PostsHomeModel.Posts.Response(userId: 1, id: 1, title: "ABC", body: "ABC")]

        postsHomePresenterMock.resultGetPosts = .success(responseMock)
        postsHomePresenterMock.isFunctionWasCalled = false

        //When
        sut.getPosts(request: requestData)
        let result = postsHomePresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }

    func testSmallWorldFailure() {
        //Given
        let requestData = PostsHomeModel.Posts.Request()
        let failure : PostsHomeError = .request

        postsHomePresenterMock.resultGetPosts = .failure(failure)
        postsHomePresenterMock.isFunctionWasCalled = false

        //When
        sut.getPosts(request: requestData)
        let result = postsHomePresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}

