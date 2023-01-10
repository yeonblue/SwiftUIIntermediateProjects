//
//  String.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/10.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
