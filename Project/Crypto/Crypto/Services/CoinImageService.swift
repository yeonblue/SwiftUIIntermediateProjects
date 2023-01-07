//
//  CoinImageService.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/07.
//

import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    var imageSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage(url: coin.image)
    }
    
    private func getCoinImage(url: String) {
        guard let url = URL(string: url) else { return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .compactMap { UIImage(data: $0) }
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] image in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
    }
}
