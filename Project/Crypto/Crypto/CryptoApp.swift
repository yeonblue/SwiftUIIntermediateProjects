//
//  CryptoApp.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/06.
//

import SwiftUI

@main
struct CryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
