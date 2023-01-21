//
//  TickerListRowView.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/21.
//

import SwiftUI

struct TickerListRowView: View {
    
    let data: TickerListRowData
    
    var body: some View {
        HStack(alignment: .center) {
            
            ZStack {
                if case let .search(isSaved, onButtonTapped) = data.type {
                    Button {
                        onButtonTapped()
                    } label: {
                        image(isSaved: isSaved)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(data.symbol)
                    .font(.headline.bold())
                
                if let name = data.name {
                    Text(name)
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                
            }
            
            Spacer()
            
            if let (price, change) = data.price {
                VStack(alignment: .trailing, spacing: 4) {
                    Text(price)
                    priceChangeView(text: change)
                }
            }
        }
    }
    
    @ViewBuilder
    func image(isSaved: Bool) -> some View {
        if isSaved {
            Image(systemName: "checkmark.circle.fill")
                .symbolRenderingMode(.palette) // iOS 15 이상
                .foregroundStyle(.white, .tint) // iOS 15 이상, 레이어 별로 색을 다르게 줄 수 있음
                .imageScale(.large)
        } else {
            Image(systemName: "plus.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.tint, .secondary.opacity(0.3))
                .imageScale(.large)
        }
    }
    
    @ViewBuilder
    func priceChangeView(text: String) -> some View {
        if case .main = data.type {
            Text(text)
                .foregroundColor(.white)
                .font(.caption.bold())
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(text.hasPrefix("-") ? .red : .green)
                )
        } else {
            Text(text)
                .foregroundColor(text.hasPrefix("-") ? .red : .green)
        }
    }
}

struct TickerListRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            
            Text("Main Type")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack(spacing: 8) {
                TickerListRowView(data: appleTickerListRowData(rowType: .main))
                TickerListRowView(data: teslaTickerListRowData(rowType: .main))
            }
            
            Text("Search List Type")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack(spacing: 8) {
                TickerListRowView(data: appleTickerListRowData(rowType: .search(isSaved: true,
                                                                                onButtonTapped: {})))
                TickerListRowView(data: teslaTickerListRowData(rowType: .search(isSaved: false,
                                                                                onButtonTapped: {})))
            }

        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
    
    static func appleTickerListRowData(rowType: TickerListRowData.RowType) -> TickerListRowData {
        .init(symbol: "AAPL", name: "Apple Inc.", price: ("100.0", "+0.1"), type: rowType)
    }
    
    static func teslaTickerListRowData(rowType: TickerListRowData.RowType) -> TickerListRowData {
        .init(symbol: "TSLA", name: "Tesla.", price: ("230.0", "-10.1"), type: rowType)
    }
}
