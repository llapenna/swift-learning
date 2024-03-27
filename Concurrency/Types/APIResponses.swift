//
//  APIResponses.swift
//  Concurrency
//
//  Created by Aerolab on 25/03/2024.
//

import Foundation

struct APIResponses {
    public struct Post: Codable, Identifiable {
        let id: Int
        let userId: Int
        let title: String
        let body: String
    }
    
    public struct Comment: Codable, Identifiable {
        let id: Int
        let postId: Int
        let name: String
        let email: String
        let body: String
    }
    
    public struct User: Codable, Identifiable {
        let id: Int
        let name: String
    }
}
