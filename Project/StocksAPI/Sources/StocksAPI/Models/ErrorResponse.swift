//
//  ErrorResponse.swift
//  
//
//  Created by yeonBlue on 2023/01/19.
//

import Foundation

public struct ErrorResponse: Codable {
    
    public let code: String
    public let description: String
    
    public init(code: String, description: String) {
        self.code = code
        self.description = description
    }
}
