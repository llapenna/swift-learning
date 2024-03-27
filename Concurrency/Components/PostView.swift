//
//  PostView.swift
//  Concurrency
//
//  Created by Aerolab on 25/03/2024.
//

import SwiftUI

struct PostView: View {
    let post: APIResponses.Post
    
    @State private var commentList: [APIResponses.Comment]? = nil
    
    @State private var phoneNumber: String = ""
    
    init(for post: APIResponses.Post) {
        self.post = post
    }
    
    var body: some View {
        Group {
            if let comments = commentList {
                Group {
                    List(comments) { comment in
                        Text(comment.name)
                    }
                    PaywallView()
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(post.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await fetchComments()
        }
    }
    
    func fetchComments() async {
        self.commentList = await API.getComments(for: post.id)
    }
}

#Preview {
    let post = APIResponses.Post(
        id: 1,
        userId: 1,
        title: "Test title",
        body: "Short description for a test post."
    )
    
    return PostView(for: post)
}
