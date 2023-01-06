//
//  CoinModel.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/06.
//

import SwiftUI

/*
 CoinGecko API
 
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h
 
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 21308501,
     "market_cap": 410680788439084,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 447930333710167,
     "total_volume": 19540571915301,
     "high_24h": 21534049,
     "low_24h": 21231528,
     "price_change_24h": -66275.33828477561,
     "price_change_percentage_24h": -0.31006,
     "market_cap_change_24h": -1165255176892,
     "market_cap_change_percentage_24h": -0.28293,
     "circulating_supply": 19253656,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 81339064,
     "ath_change_percentage": -73.75286,
     "ath_date": "2021-11-10T14:24:11.849Z",
     "atl": 75594,
     "atl_change_percentage": 28141.96643,
     "atl_date": "2013-07-05T00:00:00.000Z",
     "roi": null,
     "last_updated": "2023-01-06T06:12:58.486Z",
     "sparkline_in_7d": {
       "price": [
         16556.37512954192,
         16551.042395918797,
         16477.636843416814,
         16507.370678168394,
         16519.761996291898,
         16507.645989295783,
         16509.96557539733,
         16508.351198384305,
         16464.043978658698,
         16464.74506036054,
         16556.43165628206,
         16540.28929526149,
         16526.927173167,
         16572.473386621306,
         16522.768316767153,
         16564.34516969592,
         16588.158246622832,
         16589.02338039684,
         16609.13431538681,
         16586.47596608323,
         16569.09610919195,
         16577.45716960254,
         16555.193873101696,
         16551.31000571462,
         16544.73713791309,
         16546.7345384431,
         16565.631689833943,
         16557.105440859435,
         16545.049525087477,
         16567.29622449143,
         16579.76890855689,
         16590.381641828037,
         16611.607871078406,
         16602.348708093585,
         16598.821535416228,
         16609.04624489281,
         16583.059697606008,
         16580.246393829664,
         16581.7838283338,
         16574.68823928953,
         16551.80537614912,
         16521.815520470438,
         16542.456148037014,
         16543.034201213337,
         16558.02684830619,
         16546.030320462633,
         16539.208141738363,
         16524.263454746153,
         16530.65757502096,
         16544.695967743428,
         16539.63199727606,
         16518.854339368434,
         16535.32015174961,
         16552.887754599018,
         16563.797242980156,
         16569.56896514037,
         16551.156475909316,
         16542.454002461684,
         16556.997910266502,
         16569.203188186417,
         16587.610924804063,
         16591.826140426027,
         16614.18402080543,
         16607.992197721123,
         16604.227756384946,
         16605.620779063007,
         16619.067534998238,
         16592.18308552005,
         16573.79963708846,
         16587.601804162463,
         16631.603342664966,
         16633.211748463018,
         16659.87732360911,
         16639.835101116987,
         16721.39329788587,
         16730.802362245846,
         16714.782112258043,
         16731.399641287568,
         16727.843549256628,
         16722.209474190957,
         16694.04952308581,
         16681.276065028836,
         16732.002142639958,
         16726.89366542627,
         16716.397662217827,
         16718.037278205527,
         16735.090551715766,
         16727.59187968942,
         16743.52305034838,
         16715.600423894928,
         16674.342536301097,
         16701.238521295498,
         16668.189269852468,
         16677.10653261582,
         16690.48774163754,
         16688.349667342274,
         16720.702145446638,
         16733.064626510568,
         16714.8574232079,
         16708.697935638953,
         16750.982601171854,
         16722.12891085854,
         16724.594508186834,
         16705.952261442268,
         16729.819870642987,
         16720.91111642397,
         16675.303112763344,
         16644.931975531803,
         16625.15316314591,
         16644.549377896135,
         16637.275962026877,
         16664.743079900876,
         16667.878267521923,
         16677.78938943784,
         16676.360309578547,
         16659.853022187872,
         16711.20715592948,
         16743.058685564134,
         16823.860040950694,
         16823.860040950694,
         16859.64110312,
         16847.414958668527,
         16870.3299147353,
         16868.97971869581,
         16873.663531434013,
         16839.31631698298,
         16840.379694210023,
         16836.715819170204,
         16812.569889413244,
         16828.855757828445,
         16844.44495295743,
         16849.2538753479,
         16861.65882922434,
         16925.521898016355,
         16972.97281021798,
         16833.71355871587,
         16811.06387455646,
         16824.22707232957,
         16826.44858550658,
         16861.25234132466,
         16855.527051354722,
         16844.843586970845,
         16842.980540406577,
         16827.14015237137,
         16845.711241663426,
         16845.93967745395,
         16819.943370501744,
         16818.1872500924,
         16807.175217711523,
         16798.10765720417,
         16826.598700106602,
         16833.02400705368,
         16829.173860604646,
         16798.223442881528,
         16792.65951644109,
         16842.53847234337,
         16845.122508179462,
         16825.480380611607,
         16840.17093629641,
         16855.369721011757,
         16856.19224110698,
         16849.8296333006,
         16838.236884258906,
         16831.55500399307,
         16863.195805319527,
         16826.405479563724,
         16834.947555734005,
         16840.891889334325,
         16821.96725132923
       ]
     },
     "price_change_percentage_24h_in_currency": -0.3100633062255579
   },
 */

// MARK: - CoinModel
struct CoinModel: Identifiable, Codable {
    
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Int?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    
    var currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        
        case currentHoldings
    }
    
    mutating func updateHoldings(amount: Double) {
        self.currentHoldings = amount
    }
    
    var currentHoldingValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
