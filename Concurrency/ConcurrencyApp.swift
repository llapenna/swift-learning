//
//  ConcurrencyApp.swift
//  Concurrency
//
//  Created by Aerolab on 25/03/2024.
//

import SwiftUI

@main
struct ConcurrencyApp: App {
    @State var user: User = User()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(user)
        }
    }
}
