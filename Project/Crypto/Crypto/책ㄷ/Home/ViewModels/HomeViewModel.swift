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
    @Published var statistics: [StatisticModel] = []
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscrier()
    }
    
    private func addSubscrier() {
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map (filterCoins)
            .sink { [weak self] allCoins in
                self?.allCoins = allCoins
            }
            .store(in: &cancellable)
        
        marketDataService.$marketData
            .compactMap { $0 }
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
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
    
    private func mapGlobalMarketData(data: MarketDataModel) -> [StatisticModel] {
        var stats: [StatisticModel] = []

        let marketCap = StatisticModel(title: "Market Cap",
                                       value: data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volumne", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "₩0.00", percentageChange: 0)
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        
        return stats
    }
}
