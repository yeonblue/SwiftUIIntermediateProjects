//
//  NetworkingSandBoxApp.swift
//  NetworkingSandBox
//
//  Created by yeonBlue on 2023/01/30.
//

import SwiftUI

@main
struct NetworkingSandBoxApp: App {
    
    #if DEBUG
    @State var networkManager = NetworkManager(enviroment: .testing)
    #else
    @State var networkManager = NetworkManager(enviroment: .production)
    #endif

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.networkManager, networkManager)
        }
    }
}
