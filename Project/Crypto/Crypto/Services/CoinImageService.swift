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
    
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage(url: coin.image)
        }
    }
    
    private func downloadCoinImage(url: String) {
        guard let url = URL(string: url) else { return }

        imageSubscription = NetworkingManager.download(url: url)
            .compactMap { UIImage(data: $0) }
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] image in
                guard let self = self else { return }
                self.image = image
                self.fileManager.saveImage(image: image, imageName: self.imageName, folderName: self.folderName)
                self.imageSubscription?.cancel()
            })
    }
}
