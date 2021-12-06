//
//  PostsDetailsPresentationLogicMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Carlos Villamizar on 3/12/21.
//

import Foundation
@testable import ZemogaApp_iOS

final class PostsDetailsPresentationLogicMock: PostsDetailsPresentationLogic {
    var responseUsers: [PostsDetailsModel.Users.Response]?
    var isFunctionWasCalled = false
    
    func presentUsers(response: [PostsDetailsModel.Users.Response]) {
        if responseUsers != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: PostsHomeModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
