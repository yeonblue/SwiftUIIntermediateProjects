//
//  Quote.swift
//  
//
//  Created by yeonBlue on 2023/01/19.
//

import Foundation

/*
 // 정상 응답
 {
     "quoteResponse": {
         "result": [
             {
                 "language": "en-US",
                 "region": "US",
                 "quoteType": "EQUITY",
                 "typeDisp": "Equity",
                 "quoteSourceName": "Nasdaq Real Time Price",
                 "triggerable": true,
                 "customPriceAlertConfidence": "HIGH",
                 "exchange": "NMS",
                 "shortName": "Apple Inc.",
                 "longName": "Apple Inc.",
                 "messageBoardId": "finmb_24937",
                 "exchangeTimezoneName": "America/New_York",
                 "exchangeTimezoneShortName": "EST",
                 "gmtOffSetMilliseconds": -18000000,
                 "market": "us_market",
                 "esgPopulated": false,
                 "currency": "USD",
                 "marketState": "PREPRE",
                 "regularMarketChangePercent": -0.53699845,
                 "regularMarketPrice": 135.21,
                 "firstTradeDateMilliseconds": 345479400000,
                 "priceHint": 2,
                 "postMarketChangePercent": -0.569488,
                 "postMarketTime": 1674089999,
                 "postMarketPrice": 134.44,
                 "postMarketChange": -0.770004,
                 "regularMarketChange": -0.7299957,
                 "regularMarketTime": 1674075604,
                 "regularMarketDayHigh": 138.61,
                 "regularMarketDayRange": "135.03 - 138.61",
                 "regularMarketDayLow": 135.03,
                 "regularMarketVolume": 69459809,
                 "regularMarketPreviousClose": 135.94,
                 "bid": 0.0,
                 "ask": 0.0,
                 "bidSize": 8,
                 "askSize": 11,
                 "fullExchangeName": "NasdaqGS",
                 "financialCurrency": "USD",
                 "regularMarketOpen": 136.815,
                 "averageDailyVolume3Month": 82153011,
                 "averageDailyVolume10Day": 76681050,
                 "fiftyTwoWeekLowChange": 11.040009,
                 "fiftyTwoWeekLowChangePercent": 0.08891044,
                 "fiftyTwoWeekRange": "124.17 - 179.61",
                 "fiftyTwoWeekHighChange": -44.399994,
                 "fiftyTwoWeekHighChangePercent": -0.24720223,
                 "fiftyTwoWeekLow": 124.17,
                 "fiftyTwoWeekHigh": 179.61,
                 "dividendDate": 1668038400,
                 "earningsTimestamp": 1675371600,
                 "earningsTimestampStart": 1675371600,
                 "earningsTimestampEnd": 1675371600,
                 "trailingAnnualDividendRate": 0.9,
                 "trailingPE": 22.129297,
                 "trailingAnnualDividendYield": 0.0066205678,
                 "epsTrailingTwelveMonths": 6.11,
                 "epsForward": 6.73,
                 "epsCurrentYear": 6.17,
                 "priceEpsCurrentYear": 21.9141,
                 "sharesOutstanding": 15836199936,
                 "bookValue": 3.178,
                 "fiftyDayAverage": 139.3398,
                 "fiftyDayAverageChange": -4.1297913,
                 "fiftyDayAverageChangePercent": -0.029638276,
                 "twoHundredDayAverage": 149.5831,
                 "twoHundredDayAverageChange": -14.373093,
                 "twoHundredDayAverageChangePercent": -0.09608768,
                 "marketCap": 2141212639232,
                 "forwardPE": 20.09064,
                 "priceToBook": 42.545628,
                 "sourceInterval": 15,
                 "exchangeDataDelayedBy": 0,
                 "averageAnalystRating": "2.0 - Buy",
                 "tradeable": false,
                 "cryptoTradeable": false,
                 "displayName": "Apple",
                 "symbol": "AAPL"
             }, ...
 
 // 에러가 발생했을 경우
 {
     "finance": {
         "result": null,
         "error": {
             "code": "Bad Request",
             "description": "Missing required query parameter=symbols"
         }
     }
 }
 */

public struct QuoteResponse: Decodable {
    
    public let data: [Quote]?
    public let error: ErrorResponse?
    
    enum CodingKeys: CodingKey {
        case quoteResponse // 응답값이 정상일 경우
        case finance // 에러가 발생했을 경우
    }
    
    enum ResponseKey: CodingKey {
        case result
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let quoteResponseContainer = try? container.nestedContainer(keyedBy: ResponseKey.self, forKey: .quoteResponse) {
            self.data = try quoteResponseContainer.decodeIfPresent([Quote].self, forKey: .result)
            self.error = try? quoteResponseContainer.decodeIfPresent(ErrorResponse.self, forKey: .error)
        } else if let financeResponseContainer = try? container.nestedContainer(keyedBy: ResponseKey.self, forKey: .finance) {
            self.data = try? financeResponseContainer.decodeIfPresent([Quote].self, forKey: .result)
            self.error = try? financeResponseContainer.decodeIfPresent(ErrorResponse.self, forKey: .error)
        } else {
            self.data = nil
            self.error = nil
        }
    }
}

public struct Quote: Codable, Identifiable, Hashable {
    
    public let id = UUID()
    
    public let currency: String?
    public let marketState: String?
    public let fullExchangeName: String?
    public let displayName: String?
    public let symbol: String?
    public let regularMarketPrice: Double?
    public let regularMarketChange: Double?
    public let regularMarketChangePercent: Double?
    public let regularMarketPreviousClose: Double?
    
    public let postMarketPrice: Double?
    public let postMarketChange: Double?
    
    public let regularMarketOpen: Double?
    public let regularMarketDayHigh: Double?
    public let regularMarketDayLow: Double?
    public let regularMarketVolume: Double?

    public let trailingPE: Double?
    public let marketCap: Double?

    public let fiftyTwoWeekLow: Double?
    public let fiftyTwoWeekHigh: Double?
    public let averageDailyVolume3Month: Double?

    public let trailingAnnualDividendYield: Double?
    public let epsTrailingTwelveMonths: Double?
    
    public init(currency: String?, marketState: String?, fullExchangeName: String?, displayName: String?, symbol: String?, regularMarketPrice: Double?, regularMarketChange: Double?, regularMarketChangePercent: Double?, regularMarketPreviousClose: Double?, postMarketPrice: Double?, postMarketChange: Double?, regularMarketOpen: Double?, regularMarketDayHigh: Double?, regularMarketDayLow: Double?, regularMarketVolume: Double?, trailingPE: Double?, marketCap: Double?, fiftyTwoWeekLow: Double?, fiftyTwoWeekHigh: Double?, averageDailyVolume3Month: Double?, trailingAnnualDividendYield: Double?, epsTrailingTwelveMonths: Double?) {
        self.currency = currency
        self.marketState = marketState
        self.fullExchangeName = fullExchangeName
        self.displayName = displayName
        self.symbol = symbol
        self.regularMarketPrice = regularMarketPrice
        self.regularMarketChange = regularMarketChange
        self.regularMarketChangePercent = regularMarketChangePercent
        self.regularMarketPreviousClose = regularMarketPreviousClose
        self.postMarketPrice = postMarketPrice
        self.postMarketChange = postMarketChange
        self.regularMarketOpen = regularMarketOpen
        self.regularMarketDayHigh = regularMarketDayHigh
        self.regularMarketDayLow = regularMarketDayLow
        self.regularMarketVolume = regularMarketVolume
        self.trailingPE = trailingPE
        self.marketCap = marketCap
        self.fiftyTwoWeekLow = fiftyTwoWeekLow
        self.fiftyTwoWeekHigh = fiftyTwoWeekHigh
        self.averageDailyVolume3Month = averageDailyVolume3Month
        self.trailingAnnualDividendYield = trailingAnnualDividendYield
        self.epsTrailingTwelveMonths = epsTrailingTwelveMonths
    }
}
