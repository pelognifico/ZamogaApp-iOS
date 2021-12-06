//
//  PostsDetailsInteractorTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsDetailsInteractorTest: XCTestCase {
    var sut: PostsDetailsInteractor!
    var postsDetailsPresenterMock: PostsHomeWorkerMock!

    override func setUp() {
        postsDetailsPresenterMock = PostsHomeWorkerMock()
        sut = PostsDetailsInteractor(worker: postsDetailsPresenterMock)
    }

    func testPostsDetailsSuccess() {
        //Given
        let requestData = PostsDetailsModel.Users.Request()
        let responseMock = [PostsDetailsModel.Users.Response(id: 1, name: "ABC", email: "ABC", phone: "ABC", website: "ABC")]

        postsDetailsPresenterMock.resultGetUsers = .success(responseMock)
        postsDetailsPresenterMock.isFunctionWasCalled = false

        //When
        sut.getUsers(request: requestData)
        let result = postsDetailsPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }

    func testSmallWorldFailure() {
        //Given
        let requestData = PostsDetailsModel.Users.Request()
        let failure : PostsHomeError = .request

        postsDetailsPresenterMock.resultGetUsers = .failure(failure)
        postsDetailsPresenterMock.isFunctionWasCalled = false

        //When
        sut.getUsers(request: requestData)
        let result = postsDetailsPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}
