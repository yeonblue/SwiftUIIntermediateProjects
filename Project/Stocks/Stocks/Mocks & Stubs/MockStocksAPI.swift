//
//  MockStocksAPI.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import Foundation
import StocksAPI

#if DEBUG

struct MockStocksAPI: StockAPIService {
    
    var stubbedSearchTickersCallback: (() async throws -> [Ticker])!
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker] {
        try await stubbedSearchTickersCallback()
    }
    
    var stubedFetchQuotesCallback: (() async throws -> [Quote])!
    func fetchQuotes(symbols: String) async throws -> [Quote] {
        try await stubedFetchQuotesCallback()
    }
}

#endif
