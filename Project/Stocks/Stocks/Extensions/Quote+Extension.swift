//
//  Quote+Extension.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import Foundation
import StocksAPI

extension Quote {
    
    var regularPriceText: String? {
        return Utils.format(value: regularMarketPrice)
    }
    
    var regularDiffText: String? {
        guard let text = Utils.format(value: regularMarketChange) else {
            return nil
        }
        
        return text.hasPrefix("-") ? text : "\(text)"
    }
}
