//
//  ContentView.swift
//  Concurrency
//
//  Created by Aerolab on 25/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State var postList: [APIResponses.Post]? = nil
    
    var body: some View {
        NavigationStack {
            if let posts = postList {
                List(posts) { post in
                    NavigationLink {
                        PostView(for: post)
                    } label: {
                        Text(post.title)
                    }
                }
                .listStyle(.inset)
                .navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.large)
            } else {
                ProgressView()
            }
        }
        .task {
            await fetchPosts()
        }
        .refreshable {
            await fetchPosts()
        }
    }
    
    func fetchPosts() async {
        let posts = await API.getAllPosts()
        self.postList = posts
    }
}

#Preview {
    ContentView()
}
