//
//  Date.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/10.
//

import Foundation

extension Date {
    
    /// CoinGecKo API 날짜 string을 받아 Date를 생성
    /// - Parameter coinGeckoString: CoinModel date String
    /// ```
    /// 입력값 예시: "2021-11-10T14:24:11.849Z"
    /// ```
    init(coinGeckoString: String) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = df.date(from: coinGeckoString) ?? Date()
        
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yy/MM/dd"
        df.locale = .current
        return df
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
