//
//  Indicator.swift
//  
//
//  Created by yeonBlue on 2023/01/21.
//

/*
 
 // response
 {
     "chart": {
         "result": [
             {
                 "meta": {
                     "currency": "USD",
                     "symbol": "AAPL",
                     "exchangeName": "NMS",
                     "instrumentType": "EQUITY",
                     "firstTradeDate": 345479400,
                     "regularMarketTime": 1674248404,
                     "gmtoffset": -18000,
                     "timezone": "EST",
                     "exchangeTimezoneName": "America/New_York",
                     "regularMarketPrice": 137.87,
                     "chartPreviousClose": 135.27,
                     "previousClose": 135.27,
                     "scale": 3,
                     "priceHint": 2,
                     "currentTradingPeriod": {
                         "pre": {
                             "timezone": "EST",
                             "start": 1674205200,
                             "end": 1674225000,
                             "gmtoffset": -18000
                         },
                         "regular": {
                             "timezone": "EST",
                             "start": 1674225000,
                             "end": 1674248400,
                             "gmtoffset": -18000
                         },
                         "post": {
                             "timezone": "EST",
                             "start": 1674248400,
                             "end": 1674262800,
                             "gmtoffset": -18000
                         }
                     },
                     "tradingPeriods": [
                         [
                             {
                                 "timezone": "EST",
                                 "start": 1674225000,
                                 "end": 1674248400,
                                 "gmtoffset": -18000
                             }
                         ]
                     ],
                     "dataGranularity": "1m",
                     "range": "1d",
                     "validRanges": [
                         "1d",
                         "5d",
                         "1mo",
                         "3mo",
                         "6mo",
                         "1y",
                         "2y",
                         "5y",
                         "10y",
                         "ytd",
                         "max"
                     ]
                 },
                 "timestamp": [
                     1674225000,
                     1674225060,
                     1674225120,
                    ....
                     1674248340,
                     1674248400
                 ],
                 "indicators": {
                     "quote": [
                         {
                             "low": [
                                 134.66000366210938,
                                 134.38009643554688,
                                 ...
                                 137.625,
                                 137.8699951171875
                             ],
                             "close": [
                                 134.71499633789062,
                                 134.94000244140625,
                                 134.5749969482422,
                                 134.4600067138672,
                                 134.506103515625,
                                 134.47999572753906,
                               ...
                                 137.75030517578125,
                                 137.72999572753906,
                                 137.8780059814453,
                                 137.875,
                                 137.82009887695312,
                                 137.80999755859375,
                            
                             ],
                             "open": [
                                 134.71499633789062,
                             
                                 135.0399932861328,
                                 135.0800018310547,
                                 135.0,
                                 134.89010620117188,
                                 134.76040649414062,
                                 134.60000610351562,
                                 134.7436981201172,
                                 134.85499572753906,
                                 135.05999755859375,
                                 135.0800018310547,
                                 134.99000549316406,
                                 135.0717010498047,
                                 135.02000427246094,
                                 135.125,
                                 135.39010620117188,
                                 135.2100067138672,
                                 135.27720642089844,
                                ...
                                 137.8699951171875
                             ],
                             "volume": [
                                 6292435,
                                 496656,
                                ...
                                 607031,
                                 631425,
                                 651842,
                                 2062938,
                                 0
                             ],
                             "high": [
                                 135.2899932861328,
                                 135.02000427246094,
                                 134.9499969482422,
                                ...
                                 137.75999450683594,
                                 137.94000244140625,
                                 137.8699951171875
                             ]
                         }
                     ]
                 }
             }
         ],
         "error": null
     }
 }
 
 // error
 {
     "chart": {
         "result": null,
         "error": {
             "code": "Bad Request",
             "description": "No valid indicators were provided: quotes"
         }
     }
 }
 */


import Foundation

public struct ChartResponse: Decodable {
    
    public let data: [ChartData]?
    public let error: ErrorResponse?
    
    enum CodingKeys: CodingKey {
        case chart // 에러, 정상경우 모두 존재하므로
    }
    
    enum ChartKeys: CodingKey {
        case result
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let chartContainer = try? container.nestedContainer(keyedBy: ChartKeys.self, forKey: .chart) {
            data = try? chartContainer.decodeIfPresent([ChartData].self, forKey: .result)
            error = try? chartContainer.decodeIfPresent(ErrorResponse.self, forKey: .error)
        } else {
            data = nil
            error = nil
        }
    }
}


public struct ChartMeta: Decodable {
    
    public let currency: String
    public let symbol: String
    public let regularMarketPrice: Double?
    public let previousClose: Double?
    public let gmtOffSet: Int?
    public let regularTradingPeriodStartDate: Date
    public let regularTradingPeriodEndDate: Date
    
    enum CodingKeys: CodingKey {
        case currency
        case symbol
        case regularMarketPrice
        case previousClose
        case gmtoffSet
        case currentTradingPeriod
    }
    
    enum CurrentTradingKeys: CodingKey {
        case pre
        case regular
        case post
    }
    
    enum TradingPeriodKeys: CodingKey {
        case start
        case end
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        self.regularMarketPrice = try container.decodeIfPresent(Double.self, forKey: .regularMarketPrice)
        self.previousClose = try container.decodeIfPresent(Double.self, forKey: .previousClose)
        self.gmtOffSet = try container.decodeIfPresent(Int.self, forKey: .gmtoffSet) ?? 0
        
        let currentTradingPeriodContainer = try? container.nestedContainer(keyedBy: CurrentTradingKeys.self, forKey: .currentTradingPeriod)
        let regularTradingPeriodContainer = try? currentTradingPeriodContainer?.nestedContainer(keyedBy: TradingPeriodKeys.self, forKey: .regular)
        
        self.regularTradingPeriodStartDate = try regularTradingPeriodContainer?.decodeIfPresent(Date.self, forKey: .start) ?? Date()
        self.regularTradingPeriodEndDate = try regularTradingPeriodContainer?.decodeIfPresent(Date.self, forKey: .end) ?? Date()
    }
}

public struct Indicator: Codable {

    public let timestamp: Date
    public let open: Double
    public let high: Double
    public let low: Double
    public let close: Double
    
    public init(timestamp: Date, open: Double, high: Double, low: Double, close: Double) {
        self.timestamp = timestamp
        self.open = open
        self.high = high
        self.low = low
        self.close = close
    }
}

public struct ChartData: Decodable {
    
    public let meta: ChartMeta
    public let indicators: [Indicator]
    
    enum CodingKeys: CodingKey {
        case meta
        case timestamp
        case indicators
    }
    
    enum IndicatorsKeys: CodingKey {
        case quote
    }
    
    enum QuoteKeys: CodingKey {
        case close
        case high
        case low
        case open
    }
    
    public init(meta: ChartMeta, indicators: [Indicator]) {
        self.meta = meta
        self.indicators = indicators
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        meta = try container.decode(ChartMeta.self, forKey: .meta)
        let timestamp = try container.decodeIfPresent([Date].self, forKey: .timestamp) ?? []
        
        // json을 flatten시켜 배열로 처리하기 위함(quote가 []이므로)
        if let indicatorsContainer = try? container.nestedContainer(keyedBy: IndicatorsKeys.self, forKey: .indicators),
           var quotes = try? indicatorsContainer.nestedUnkeyedContainer(forKey: .quote),
           let quoteContainer = try? quotes.nestedContainer(keyedBy: QuoteKeys.self) {
            
            let highs = try quoteContainer.decodeIfPresent([Double?].self, forKey: .high)
            let opens = try quoteContainer.decodeIfPresent([Double?].self, forKey: .open)
            let lows = try quoteContainer.decodeIfPresent([Double?].self, forKey: .low)
            let closes = try quoteContainer.decodeIfPresent([Double?].self, forKey: .close)
            
            self.indicators = timestamp.enumerated().compactMap({ (offset, timestamp) in
                guard let open = opens?[offset],
                      let close = closes?[offset],
                      let high = highs?[offset],
                      let low = lows?[offset] else {
                    return nil
                }
                
                return .init(timestamp: timestamp, open: open, high: high, low: low, close: close)
            })
        } else {
            self.indicators = []
        }
    }
}
