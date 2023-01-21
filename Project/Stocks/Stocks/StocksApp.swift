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
    
    let stocksAPI = StocksAPI()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    do {
                        let quotes = try await stocksAPI.fetchQuotes(symbols: "AAPL")
                        print(quotes)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
