//
//  FetchPhase.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import Foundation

enum FetchPhase<T> {
    case initial
    case fetching
    case success(T)
    case failure(Error)
    case empty
    
    var value: T? {
        if case .success(let t) = self {
            return t
        }
        
        return nil
    }
    
    var error: Error? {
        if case .failure(let error) = self {
            return error
        }
        
        return nil
    }
}
