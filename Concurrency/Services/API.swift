//
//  API.swift
//  Concurrency
//
//  Created by Aerolab on 25/03/2024.
//

import Foundation
import Alamofire

struct API {
    static let baseURL = "https://jsonplaceholder.typicode.com/"
    
    static private func get<T: Decodable>(_ path: String, using type: T.Type) async -> T? {
        let path = "\(API.baseURL)/\(path)"
        
        // TODO: change to unsafe when releasing to prod
        return await withCheckedContinuation { continuation in
            AF.request(path).responseDecodable(of: T.self) { response in
                continuation.resume(returning: response.value)
            }
        }
    }
    static private func post<T: Decodable>(_ path: String, sending body: Encodable, using type: T.Type) async -> T? {
        let path = "\(API.baseURL)/\(path)"
        
        // TODO: change to unsafe when releasing to prod
        return await withCheckedContinuation { continuation in
            AF.request(
                path,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default
            ).responseDecodable(of: T.self) { response in
                continuation.resume(returning: response.value)
            }
        }
    }
    
    static public func getAllPosts() async -> [APIResponses.Post] {
        let posts = await API.get("posts", using: [APIResponses.Post].self)
        return posts ?? []
    }
    
    static public func getComments(for post: Int) async -> [APIResponses.Comment] {
        let path = "posts/\(post)/comments"
        let comments = await API.get(path, using: [APIResponses.Comment].self)
        
        return comments ?? []
    }
    
    static public func getUser(for user: Int) async -> APIResponses.User? {
        let path = "/users/\(user)"
        return await API.get(path, using: APIResponses.User.self)
    }
}
