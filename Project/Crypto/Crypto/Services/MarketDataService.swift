//
//  MarketDataService.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/09.
//

import SwiftUI
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel?
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalDataModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] marketData in
                self?.marketData = marketData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}

