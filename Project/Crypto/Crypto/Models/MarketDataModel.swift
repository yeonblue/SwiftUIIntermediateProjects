//
//  MarketDataModel.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/09.
//

import SwiftUI

/* JSON Data Sample
 https://api.coingecko.com/api/v3/globa
 
 {
   "data": {
     "active_cryptocurrencies": 12695,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 628,
     "total_market_cap": {
       "btc": 51042846.8586583,
       "eth": 678951521.9147639,
       "ltc": 11159018276.45539,
       "bch": 8350811282.779794,
       "bnb": 3177853597.532253,
       "eos": 957808379208.7461,
       "xrp": 2529489911636.6113,
       "xlm": 11264873233579.533,
       "link": 146169560216.54416,
       "dot": 181346322108.6645,
       "yfi": 152973852.34624553,
       "usd": 874612744698.2842,
       "aed": 3212299554046.4795,
       "ars": 156520717781911.1,
       "aud": 1268584679385.861,
       "bdt": 90867528146139.42,
       "bhd": 329730753976.74304,
       "bmd": 874612744698.2842,
       "brl": 4569495623661.446,
       "cad": 1175509265707.8162,
       "chf": 810445906070.7506,
       "clp": 735712393335958,
       "cny": 5981004270109.435,
       "czk": 19661557759253.605,
       "dkk": 6100377539795.064,
       "eur": 820214455816.2875,
       "gbp": 721793409042.6422,
       "hkd": 6828184786070.248,
       "huf": 323621965286181.8,
       "idr": 13663258044857670,
       "ils": 3068054047127.114,
       "inr": 71957744646203.97,
       "jpy": 115329497660522.53,
       "krw": 1096545724292411.8,
       "kwd": 267605261495.3343,
       "lkr": 319962228720364.6,
       "mmk": 1838377368436582.8,
       "mxn": 16742364550499.648,
       "myr": 3851357221278.8984,
       "ngn": 399315480082550.8,
       "nok": 8732189618283.343,
       "nzd": 1375176358420.477,
       "php": 48559956690481.445,
       "pkr": 199376553355774.34,
       "pln": 3845199072943.4766,
       "rub": 63411797689614.945,
       "sar": 3287669307320.853,
       "sek": 9190607393064.035,
       "sgd": 1166617077932.4692,
       "thb": 29498664024781.902,
       "try": 16420635628524.117,
       "twd": 26742289599193.703,
       "uah": 32166926464018.254,
       "vef": 87574974126.63927,
       "vnd": 20526001816251804,
       "zar": 14968262450805.621,
       "xdr": 656500069199.9384,
       "xag": 36510656550.66523,
       "xau": 468110233.2174159,
       "bits": 51042846858658.3,
       "sats": 5104284685865830
     },
     "total_volume": {
       "btc": 1742253.2978981303,
       "eth": 23174756.13075641,
       "ltc": 380892477.39836895,
       "bch": 285039518.6192491,
       "bnb": 108470162.8392586,
       "eos": 32693019886.837185,
       "xrp": 86339465993.19397,
       "xlm": 384505640838.47046,
       "link": 4989227952.836945,
       "dot": 6189921746.144203,
       "yfi": 5221479.896692297,
       "usd": 29853290570.83818,
       "aed": 109645911940.83887,
       "ars": 5342545597036.185,
       "aud": 43300794868.34397,
       "bdt": 3101595234741.654,
       "bhd": 11254750251.787153,
       "bmd": 29853290570.83818,
       "brl": 155971292943.36728,
       "cad": 40123837539.08601,
       "chf": 27663074054.818092,
       "clp": 25112183635515.04,
       "cny": 204150533437.0543,
       "czk": 671110957872.9049,
       "dkk": 208225119507.1961,
       "eur": 27996505457.203842,
       "gbp": 24637084815.976765,
       "hkd": 233067475549.13782,
       "huf": 11046238033184.525,
       "idr": 466370076390997.06,
       "ils": 104722357993.44334,
       "inr": 2456144702632.203,
       "jpy": 3936559381187.732,
       "krw": 37428562903921.97,
       "kwd": 9134211315.959368,
       "lkr": 10921319685293.592,
       "mmk": 62749615863101.44,
       "mxn": 571469689641.2001,
       "myr": 131458965028.68607,
       "ngn": 13629896349670.15,
       "nok": 298057163669.84534,
       "nzd": 46939104950.08381,
       "php": 1657504428075.028,
       "pkr": 6805350386696.498,
       "pln": 131248768009.77676,
       "rub": 2164444588216.3853,
       "sar": 112218519255.78082,
       "sek": 313704407683.06415,
       "sgd": 39820319133.85232,
       "thb": 1006882410439.9912,
       "try": 560488067144.8444,
       "twd": 912798660634.2435,
       "uah": 1097958620340.4717,
       "vef": 2989209984.85803,
       "vnd": 700617159071360.9,
       "zar": 510913991355.81714,
       "xdr": 22408417261.70147,
       "xag": 1246223823.682207,
       "xau": 15978078.179324022,
       "bits": 1742253297898.1304,
       "sats": 174225329789813.03
     },
     "market_cap_percentage": {
       "btc": 37.726134385338575,
       "eth": 17.79955560224215,
       "usdt": 7.605104858575181,
       "bnb": 5.131678677910244,
       "usdc": 5.041136713660538,
       "xrp": 2.0012484803191923,
       "busd": 1.8660650123988969,
       "ada": 1.1924918869408396,
       "doge": 1.1611671187792554,
       "matic": 0.8628272911117141
     },
     "market_cap_change_percentage_24h_usd": 1.9082107249756606,
     "updated_at": 1673223065
   }
 }
 */

// MARK: - MarketDataModel
struct GlobalDataModel: Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "krw" }) {
            return "₩" + "\(item.value.formattedWithAbbreviations())"
        } else {
            return ""
        }
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "krw" }) {
            return "₩" + "\(item.value.formattedWithAbbreviations())"
        } else {
            return ""
        }
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return "\(item.value.aspercentString())"
        } else {
            return ""
        }
    }
}
