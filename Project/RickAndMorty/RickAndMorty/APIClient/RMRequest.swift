//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/24.
//

import Foundation

/// Object that represents a signle API call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired Endpoint
    private let endPoint: RMEndPoint
    
    /// Path Components, can be empty
    private let pathComponents: [String]
    
    /// Query param, can be empty
    private let queryParam: [URLQueryItem]
    
    /// 여기서는 GET만 사용
    let httpMethod = "GET"
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// API call을 위한 urlString 생성
    private var urlString: String {
        var urlStr = Constants.baseURL
        urlStr += "/\(endPoint.rawValue)"
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                urlStr += "/\($0)"
            }
        }
        
        if !queryParam.isEmpty {
            urlStr += "?"
            let argumentStr = queryParam.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            urlStr += argumentStr
        }
        
        return urlStr
    }
    
    /// Init Constructor
    /// - Parameters:
    ///   - endPoint: Target Endpoint
    ///   - pathComponents: Path Components, can be empty
    ///   - queryParam: Query param, can be empty
    public init(
        endPoint: RMEndPoint,
        pathComponents: [String] = [],
        queryParam: [URLQueryItem] = []
    ) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParam = queryParam
    }
}

extension RMRequest {
    static let listCharacterRequests = RMRequest(endPoint: .character)
}
