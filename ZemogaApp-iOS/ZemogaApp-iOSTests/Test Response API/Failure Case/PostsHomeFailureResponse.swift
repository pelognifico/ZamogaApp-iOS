//
//  PostsHomeFailureResponse.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsHomeFailureResponse: XCTestCase {
    var sut: PostsWorker!
    var postsHomeServiceProtocolMock: PostsHomeWorkerMock!
    
    override func setUp() {
        postsHomeServiceProtocolMock = PostsHomeWorkerMock()
        sut = PostsWorker(postsService: postsHomeServiceProtocolMock)
    }
    
    //MARK: -- Test Posts
    func testGetPosts(){
        //Given
        let requestData = PostsHomeModel.Posts.Request()
        let failure : PostsHomeError = .request
        
        //When
        postsHomeServiceProtocolMock.resultGetPosts = .failure(failure)
        
        //Then
        sut.getPosts(request: requestData, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
            }
        })
    }
    
    //MARK: -- Test Users
    func testGetUsers(){
        //Given
        let requestData = PostsDetailsModel.Users.Request()
        let failure : PostsHomeError = .request
        
        //When
        postsHomeServiceProtocolMock.resultGetUsers = .failure(failure)
        
        //Then
        sut.getUsers(request: requestData, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
            }
        })
    }
}


