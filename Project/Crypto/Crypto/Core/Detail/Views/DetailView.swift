//
//  DetailView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/10.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    
    private let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Hi")
                    .frame(height: 150)
                
                // overviewGridView
                Group {
                    overviewTitle
                    Divider()
                    overviewGridView
                }

                // additionalGridView
                Group {
                    additionalTitle
                    Divider()
                    additionalGridView
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(coin.id)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGridView: some View {
        LazyVGrid(columns: column,
                  alignment: .center,
                  spacing: 32) {
            ForEach(viewModel.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalGridView: some View {
        LazyVGrid(columns: column,
                  alignment: .center,
                  spacing: 32) {
            ForEach(viewModel.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
}
