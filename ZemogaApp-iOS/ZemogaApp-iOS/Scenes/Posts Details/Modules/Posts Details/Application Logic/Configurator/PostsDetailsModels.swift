//
//  PostsDetailsModels.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 3/12/21.
//

import Foundation

enum PostsDetailsModel {
    // MARK: Use cases
    enum Users {
        struct Request {
        }
        
        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
            }
            
            let id      : Int?
            let name    : String?
            let email   : String?
            let phone   : String?
            let website : String?
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case email
                case phone
                case website
            }
        }
        
        struct ViewModel {
            let data: [PostsDetailsModel.Users.Response]
            
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var error: PostsHomeError
        }
        struct ViewModel {
            var error: PostsHomeError
        }
    }
}
