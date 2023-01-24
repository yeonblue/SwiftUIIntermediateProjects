//
//  RMService.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/24.
//

import Foundation


/// Rick And Morty 데이터를 얻기 위한 API service object
final class RMService {
    
    /// shared singleton instance
    static let shared = RMService()
    private init() {}
    
    /// API Call 함수
    /// - Parameters:
    ///   - request: request 객체,
    ///   - completion: callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
