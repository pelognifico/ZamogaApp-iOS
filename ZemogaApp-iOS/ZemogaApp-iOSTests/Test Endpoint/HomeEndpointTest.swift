//
//  HomeEndpointTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 2/12/21.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsHomeEndpointTest: XCTestCase {
    var sut: PostsHomeEndpoint!
    
    //MARK: - GET METHOD
    
    func testGetPosts() {
        sut = .getPosts

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "posts")
        XCTAssertNil(sut.parameter)
    }
    
    func testGetUsers() {
        sut = .getUsers

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "users")
        XCTAssertNil(sut.parameter)
    }
}
