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
    @State private var showFullDescription: Bool = false
    
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
                
                ChartView(coin: coin)
                
                // overviewGridView
                Group {
                    overviewTitle
                    Divider()
                    
                    descriptionSectionView
                    overviewGridView
                }

                // additionalGridView
                Group {
                    additionalTitle
                    Divider()
                    additionalGridView
                }
                
                websiteSectionView
            }
            .padding(.horizontal)
        }
        .background(Color.theme.background)
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Text(viewModel.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundColor(.theme.secondaryText)
                    CoinImageView(coin: coin)
                        .frame(width: 25, height: 25)
                }
            }
        }
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
    
    private var descriptionSectionView: some View {
        ZStack {
            if let coinDescription = viewModel.coinDescription,
               !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                        .lineLimit(showFullDescription ? nil : 3)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 4)
                    }
                    .accentColor(.blue)

                }
            }
        }
    }
    
    private var websiteSectionView: some View {
        VStack {
            if let website = viewModel.websiteURL,
               let url = URL(string: website) {
                Link("Website", destination: url)
            }
            
            if let website = viewModel.redditURL,
               let url = URL(string: website) {
                Link("Reddit", destination: url)
            }
        }
        .padding(.horizontal)
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
