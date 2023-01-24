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
    ///   - type: Codable Type
    ///   - completion: callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        // baseURL: https://rickandmortyapi.com/api
        // EndPoint
        // Path components
        // query param
    }
}
