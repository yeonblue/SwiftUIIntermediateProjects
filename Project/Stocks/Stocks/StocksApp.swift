//
//  StocksApp.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/21.
//

import SwiftUI
import StocksAPI

@main
struct StocksApp: App {
    
    @StateObject var appVM = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainListView()
            }
            .environmentObject(appVM)
        }
    }
}
