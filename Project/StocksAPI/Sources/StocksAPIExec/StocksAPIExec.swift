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
    
    static func main() async {
        
        let url = URL(string: "https://query1.finance.yahoo.com/v7/finance/quote?symbols=AAPL,MSFT,GOOG,TSLA")!
        let (data, _) = try! await URLSession.shared.data(from: url)
        let quoteResponse = try! JSONDecoder().decode(QuoteResponse.self, from: data)
        print(quoteResponse)
        
        let url2 = URL(string: "https://query1.finance.yahoo.com/v1/finance/search?q=Apple")!
        let (data2, _) = try! await URLSession.shared.data(from: url2)
        let quoteResponse2 = try! JSONDecoder().decode(SearchTickersResponse.self, from: data2)
        print(quoteResponse2)
    }
}
