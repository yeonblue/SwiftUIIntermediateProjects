//
//  StockAPIService.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import Foundation
import StocksAPI

protocol StockAPIService {
    func searchTickers(query: String, isEquityTypeOnly: Bool) async throws -> [Ticker]
    func fetchQuotes(symbols: String) async throws -> [Quote]
}

extension StocksAPI: StockAPIService {
    
}
