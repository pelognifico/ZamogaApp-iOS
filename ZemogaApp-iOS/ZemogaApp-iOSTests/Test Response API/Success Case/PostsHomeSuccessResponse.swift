//
//  PostsHomeSuccessResponse.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsHomeSuccessResponse: XCTestCase {
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
//        let lfsResponseMock : [DataPosts] = [.init(userId: 1, id: 1, title: "ABC", body: "ABBC")]
        let dataMock = PostsHomeModel.Posts.Response(userId: 1, id: 1, title: "ABC", body: "ABC")
        let success : [PostsHomeModel.Posts.Response]? = .some([dataMock])
        
        //When
        postsHomeServiceProtocolMock.resultGetPosts = .success(success!)
        
        //Then
        sut.getPosts(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response[0].userId, dataMock.userId)
                XCTAssertEqual(response[0].id, dataMock.id)
                XCTAssertEqual(response[0].title, dataMock.title)
                XCTAssertEqual(response[0].body, dataMock.body)
            case .failure(_):
                break
            }
        })
    }
    
    //MARK: -- Test Users
    func testGetUsers(){
        //Given
        let requestData = PostsDetailsModel.Users.Request()
//        let lfsResponseMock : [DataPosts] = [.init(userId: 1, id: 1, title: "ABC", body: "ABBC")]
        let dataMock = PostsDetailsModel.Users.Response(id: 1, name: "ABC", email: "ABC", phone: "23ABC", website: "ABC")
        let success : [PostsDetailsModel.Users.Response]? = .some([dataMock])
        
        //When
        postsHomeServiceProtocolMock.resultGetUsers = .success(success!)
        
        //Then
        sut.getUsers(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response[0].id, dataMock.id)
                XCTAssertEqual(response[0].name, dataMock.name)
                XCTAssertEqual(response[0].email, dataMock.email)
                XCTAssertEqual(response[0].phone, dataMock.phone)
                XCTAssertEqual(response[0].website, dataMock.website)
            case .failure(_):
                break
            }
        })
    }
}
