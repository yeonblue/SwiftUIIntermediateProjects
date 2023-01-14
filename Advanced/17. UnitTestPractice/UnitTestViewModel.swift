//
//  UnitTestViewModel.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/14.
//

import SwiftUI

class UnitTestViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = dataArray.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: { $0 == item }) {
            print("Save item: \(x)")
        } else {
            throw DataError.itemNotFound
        }
    }
}

enum DataError: LocalizedError {
    case noData
    case itemNotFound
}
