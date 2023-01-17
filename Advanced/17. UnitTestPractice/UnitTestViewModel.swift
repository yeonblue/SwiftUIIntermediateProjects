//
//  UnitTestViewModel.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/14.
//

import SwiftUI
import Combine

class UnitTestViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    let dataService: NewDataSerciceProtocol
    var cancellable = Set<AnyCancellable>()
    
    init(isPremium: Bool, dataService: NewDataSerciceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
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
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] items in
            self?.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] items in
                self?.dataArray = items
            }
            .store(in: &cancellable)
    }
}

enum DataError: LocalizedError {
    case noData
    case itemNotFound
}
