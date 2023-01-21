//
//  StocksAPIExec.swift
//  
//
//  Created by yeonBlue on 2023/01/19.
//

import Foundation
import StocksAPI

@main // 시작 지점
struct StocksAPIExec {
    
    static let stocksAPI = StocksAPI()
    
    static func main() async {
        
        do {
            let quotes = try await stocksAPI.fetchChartData(symbol: "AAPL", range: .oneDay)
            print(quotes)
        } catch {
            print(error.localizedDescription)
        }
    }
}
