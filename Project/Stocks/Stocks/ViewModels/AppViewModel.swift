//
//  AppViewModel.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import SwiftUI
import StocksAPI

@MainActor
class AppViewModel: ObservableObject {
    
    @Published var tickers: [Ticker] = []
    @Published var subtitleText: String
    
    var titleText = "Stocks"
    var emptyTickerText = "Search & add symbols to see stock quotes"
    var attributionText = "Powered by Yahoo Finance API"
    
    private let subtitleDataFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM d"
        return df
    }()
    
    init() {
        self.subtitleText = subtitleDataFormatter.string(from: Date())
    }
    
    func removeTickers(_ offsets: IndexSet) {
        tickers.remove(atOffsets: offsets)
    }
    
    func openYahooFinance() {
        let url = URL(string: "https://finance.yahoo.com")!
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func isAddedToMyTickers(ticker: Ticker) -> Bool {
        return tickers.first(where: { $0.symbol == ticker.symbol }) != nil
    }
    
    @MainActor
    func toggleTicker(_ ticker: Ticker) {
        if isAddedToMyTickers(ticker: ticker) {
            removeFromMyTickers(ticker: ticker)
        } else {
            addToMyTickers(ticker: ticker)
        }
    }
    
    func addToMyTickers(ticker: Ticker) {
        tickers.append(ticker)
    }
    
    func removeFromMyTickers(ticker: Ticker) {
        guard let index = tickers.firstIndex(where: { $0.symbol == ticker.symbol }) else {
            return
        }
        
        tickers.remove(at: index)
    }
}
