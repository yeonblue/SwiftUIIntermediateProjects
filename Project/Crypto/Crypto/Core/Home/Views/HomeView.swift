//
//  HomeView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/06.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showProtfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    
    var body: some View {
        ZStack {
            
            // background
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) { //view 안이라면 어디에 둬도 상관 없음
                    PortfolioView()
                }
            
            // content
            VStack {

                homeHeaderView
                
                HomeStatsView(showPortfolio: $showProtfolio)
                
                SearchBarView(searchText: $viewModel.searchText)
                
                columnTitleView
                
                if !showProtfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                } else if showProtfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
                .environmentObject(dev.homeViewModel)
        }
    }
}

extension HomeView {
    private var homeHeaderView: some View {
        HStack {
            CircleButtonView(iconName: showProtfolio ? "plus" : "info")
                .animation(.none, value: showProtfolio)
                .background(
                    CircleButtonAnimationView(animate: $showProtfolio)
                )
                .onTapGesture {
                    if showProtfolio {
                        showPortfolioView.toggle()
                    }
                }
            
            Spacer()
            
            Text(showProtfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none, value: showProtfolio)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProtfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showProtfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 8,
                                         leading: 16,
                                         bottom: 8,
                                         trailing: 16))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 8,
                                         leading: 16,
                                         bottom: 8,
                                         trailing: 16))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitleView: some View {
        HStack {
            Text("Coin")
            
            Spacer()
            
            if showProtfolio {
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3,
                       alignment: .trailing)
        }
        .font(.footnote)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal, 16)
    }
}

