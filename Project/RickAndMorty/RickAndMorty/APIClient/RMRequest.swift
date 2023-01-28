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
    
    // MARK: - Init
    
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
    
    /// create request
    /// - Parameter url: URL to parse
    convenience init?(url: URL) {
        let string = url.absoluteString
        guard string.contains(Constants.baseURL) else {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseURL + "/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            var pathComponents: [String] = []
            
            if !components.isEmpty {
                let endpointString = components[0]
                
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let rmEndPoint = RMEndPoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndPoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                
                let queryItemStr = components[1]
                let queryItem: [URLQueryItem] = queryItemStr.components(separatedBy: "&").compactMap({ query in
                    guard query.contains("=") else {
                        return nil
                    }
                    
                    let parts = query.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                
                if let rmEndPoint = RMEndPoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndPoint, queryParam: queryItem)
                    return
                }
            }
        }
        return nil
    }
}

extension RMRequest {
    static let listCharacterRequests = RMRequest(endPoint: .character)
}
