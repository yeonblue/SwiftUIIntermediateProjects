//
//  CryptoApp.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/06.
//

import SwiftUI

@main
struct CryptoApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(.stack)
            .environmentObject(viewModel)
        }
    }
}
