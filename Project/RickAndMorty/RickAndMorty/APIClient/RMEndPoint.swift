//
//  RMEndPoint.swift
//  RickAndMorty
//
//  Created by yeonBlue on 2023/01/24.
//

import Foundation

/// API Endpoint
@frozen enum RMEndPoint: String { // @frozen 새로운 case가 추가되지 않음을 약속, default 케이스를 추가하지 않아도 됨
    
    /// Endpoint to get character info
    case character
    
    /// Endpoint to get location info
    case location
    
    /// Endpoint to get episode info
    case episode
}
