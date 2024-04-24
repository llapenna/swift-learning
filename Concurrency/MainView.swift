//
//  ContentView.swift
//  Concurrency
//
//  Created by Aerolab on 25/03/2024.
//

import SwiftUI

struct MainView: View {
    @Environment(User.self) var user
    
    var body: some View {
        if user.instance != nil {
            PostListView()
        } else {
            LoginView()
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static let user = User()

    static var previews: some View {
        MainView()
            .environment(user)
    }
}
