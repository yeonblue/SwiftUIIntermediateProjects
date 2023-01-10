//
//  DetailViewModel.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/10.
//

import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coin: CoinModel
    
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    private let coinDetailService: CoinDetailDataService
   
    
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArray in
                self?.overviewStatistics = returnedArray.overview
                self?.additionalStatistics = returnedArray.additional
            }
            .store(in: &cancellable)
        
        coinDetailService.$coinDetail
            .sink { [weak self] coinDetail in
                self?.coinDescription = coinDetail?.readableDescription
                self?.websiteURL = coinDetail?.links?.homepage?.first
                self?.redditURL = coinDetail?.links?.subredditURL
            }
            .store(in: &cancellable)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?,
                                     coinModel: CoinModel) -> (overview: [StatisticModel],
                                                               additional: [StatisticModel]) {

        let overviewArray = createOverViewArray(coinModel: coinModel)
        let additionalArray = createAditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        return (overviewArray, additionalArray)
    }
    
    private func createOverViewArray(coinModel: CoinModel) -> [StatisticModel] {

        var overviewArray: [StatisticModel] = []
        
        let price = coinModel.currentPrice.asCurrenyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let pricePercentChangeStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = coinModel.marketCap?.formattedWithAbbreviations() ?? ""
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume =  "₩" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        overviewArray.append(contentsOf: [pricePercentChangeStat, marketCapStat, rankStat, volumeStat])
        
        return overviewArray
    }
    
    private func createAditionalArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticModel] {

        var additionalArray: [StatisticModel] = []
        
        let high = coinModel.high24H?.asCurrenyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h high", value: high)
        
        let low = coinModel.low24H?.asCurrenyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrenyWith6Decimals() ?? "n/a"
        let priceChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h price change", value: priceChange, percentageChange: priceChange2)
        
        let marketCapChange =  "₩" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h market cap change", value: marketCapChange, percentageChange: marketCapChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        additionalArray.append(contentsOf: [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ])
        
        return additionalArray
    }
}
