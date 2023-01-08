//
//  HomeViewModel.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/07.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentageChange: 1),
        StatisticModel(title: "Title", value: "Value", percentageChange: nil),
        StatisticModel(title: "Title", value: "Value", percentageChange: nil),
        StatisticModel(title: "Title", value: "Value", percentageChange: -1),
    ]
    
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscrier()
    }
    
    private func addSubscrier() {
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterCoins)
            .sink { [weak self] allCoins in
                self?.allCoins = allCoins
            }
            .store(in: &cancellable)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowerCasedText = text.lowercased()
        
        return coins.filter {
            $0.name.lowercased().contains(lowerCasedText)
            || $0.symbol.lowercased().contains(lowerCasedText)
            || $0.id.lowercased().contains(lowerCasedText)
        }
    }
}
