//
//  PostListView.swift
//  Concurrency
//
//  Created by Aerolab on 28/03/2024.
//

import SwiftUI

private enum SheetStatus: String, Identifiable {
    case profile
    
    var id: String {
        return self.rawValue
    }
}

struct PostListView: View {
    @State private var postList: [APIResponses.Post]? = nil
    @State private var sheet: SheetStatus? = nil
    
    var body: some View {
        NavigationStack {
            Group {
                if let posts = postList {
                    List(posts) { post in
                        NavigationLink {
                            PostView(for: post)
                        } label: {
                            Text(post.title)
                        }
                    }
                    .listStyle(.inset)
                } else { ProgressView() }
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                Button {
                    openProfile()
                } label: {
                    Image(systemName: "person.circle")
                }
            }
            .sheet(item: $sheet) { item in
                Text("This is the profile for")
            }
        }
        .task {
            await fetchPosts()
        }
        .refreshable {
            await fetchPosts()
        }
    }
}

extension PostListView {
    func fetchPosts() async {
        let posts = await API.getAllPosts()
        self.postList = posts
    }
    
    func openProfile() {
        self.sheet = .profile
    }
}

#Preview {
    PostListView()
}
