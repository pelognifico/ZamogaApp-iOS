//
//  PostsAPI.swift
//  ZemogaApp-iOS
//
//  Created by Carlos Villamizar on 2/12/21.
//

import Foundation

class PostsAPI: PostsServiceProtocol {
    func getPosts(request: PostsHomeModel.Posts.Request, completion: @escaping (Result<[PostsHomeModel.Posts.Response], PostsHomeError>) -> Void) {
        NetworkService.share.request(endpoint: PostsHomeEndpoint.getPosts) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([PostsHomeModel.Posts.Response].self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
    
    func getUsers(request: PostsDetailsModel.Users.Request, completion: @escaping (Result<[PostsDetailsModel.Users.Response], PostsHomeError>) -> Void) {
        NetworkService.share.request(endpoint: PostsHomeEndpoint.getUsers) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([PostsDetailsModel.Users.Response].self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
