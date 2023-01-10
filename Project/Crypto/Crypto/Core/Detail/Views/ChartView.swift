//
//  ChartView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/10.
//

import SwiftUI

struct ChartView: View {
    
    @State private var animatePercentage: CGFloat = 0.0
    
    let data: [Double]
    let startDate: Date
    let endingDate: Date
    
    let maxY: Double
    let minY: Double
    var midY: Double {
        return (minY + maxY) / 2
    }
    
    let lineColor: Color
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.maxY = data.max() ?? 0
        self.minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .theme.green : .theme.red
        
        self.endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        self.startDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60) // 1주일 전
    }
    
    var body: some View {
        
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(
                    VStack {
                        Text(maxY.formattedWithAbbreviations())
                        Spacer()
                        Text(midY.formattedWithAbbreviations())
                        Spacer()
                        Text(minY.formattedWithAbbreviations())
                    }
                    ,alignment: .leading)
            
            chartDateLabel
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .onAppear {
            withAnimation(.linear(duration: 2.0)) {
                animatePercentage = 1.0
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
            .previewLayout(.fixed(width: 375, height: 200))
    }
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPos = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    // (0, 0)이 좌상이므로, 반전을 시켜줘야 하므로 1에서 빼기를 진행
                    let yPos = (1 - (data[index] - minY) / yAxis) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPos, y: yPos))
                    }
                    
                    path.addLine(to: CGPoint(x: xPos, y: yPos))
                }
            }
            .trim(from: 0.0, to: animatePercentage) // shape에 존재하는 속성, 원하는 만큼 자르기 가능
            .stroke(lineColor,
                    style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, y: 30)
            .shadow(color: lineColor.opacity(0.6), radius: 10, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, y: 10)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartDateLabel: some View {
        HStack {
            Text(startDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
