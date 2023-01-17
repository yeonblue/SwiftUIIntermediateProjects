//
//  NewMockDataService.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/17.
//

import SwiftUI
import Combine

protocol NewDataSerciceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataSerciceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "One", "Two", "Three"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ items in
                guard !items.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return items
            })
            .eraseToAnyPublisher()
    }
}
