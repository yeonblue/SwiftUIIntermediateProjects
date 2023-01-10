//
//  DetailViewModel.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/10.
//

import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private let coin: CoinModel
    
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .sink { returnedCoinDetail in
                print(returnedCoinDetail)
            }
            .store(in: &cancellable)
    }
}
