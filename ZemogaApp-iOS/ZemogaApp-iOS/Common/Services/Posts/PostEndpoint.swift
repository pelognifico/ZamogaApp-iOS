//
//  PostEndpoint.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import Alamofire

enum PostsHomeEndpoint {
    case getPosts
    case getUsers
}

extension PostsHomeEndpoint: IEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getPosts, .getUsers:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "posts"
        case .getUsers:
            return "users"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getPosts, .getUsers:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getPosts, .getUsers:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
