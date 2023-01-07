//
//  CoinRowView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/07.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
    
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
            
            
            Spacer()
            
            rightColumn
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
            .previewLayout(.sizeThatFits)
    }
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            
            Circle()
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingValue.asCurrenyWith6Decimals())
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrenyWith6Decimals())")
                .foregroundColor(.theme.accent)
                .bold()
            
            Text(coin.priceChangePercentage24H?.aspercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? .theme.green
                                                              : .theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3, // portrait모드만 지원할 것이므로 괜찮음
               alignment: .trailing)
    }
}
