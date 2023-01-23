//
//  Stubs.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import SwiftUI
import StocksAPI

#if DEBUG
extension Ticker {
    static var stubs: [Ticker] = [
        Ticker(symbol: "AAPL", shortName: "Apple"),
        Ticker(symbol: "TSLA", shortName: "Tesla"),
        Ticker(symbol: "NVDA", shortName: "Nvidia")
    ]
}

extension Quote {
    static var stubs: [Quote] = [
        Quote(symbol: "AAPL", regularMarketPrice: 123.24, regularMarketChange: -2.34),
        Quote(symbol: "TSLA", regularMarketPrice: 323.54, regularMarketChange: 5.26),
        Quote(symbol: "NVDA", regularMarketPrice: 75.2, regularMarketChange: 12.54)
    ]
    
    static var stubsDict: [String: Quote] {
        var dict = [String: Quote]()
        stubs.forEach { quote in
            dict[quote.symbol] = quote
        }
        return dict
    }
}

#endif
