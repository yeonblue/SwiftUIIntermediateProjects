//
//  ContentView.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/21.
//

import SwiftUI
import StocksAPI

struct MainListView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    
    var body: some View {
        tickerListView
            .overlay {
                overlayView
            }
            .listStyle(.plain)
            .toolbar {
                titleToolBar
                attributionToolbar
            }
    }
    
    private var tickerListView: some View {
        List {
            ForEach(appVM.tickers) { ticker in
                TickerListRowView(data: TickerListRowData(symbol: ticker.symbol,
                                                          name: ticker.shortName,
                                                          price: quotesVM.priceForTicker(ticker),
                                                          type: .main))
                .contentShape(Rectangle()) // empty 부분도 탭할 수 있게 하기 위함
                .onTapGesture {
                    
                }
            }
            .onDelete {
                appVM.removeTickers($0)
            }
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        if appVM.tickers.isEmpty {
            EmptyStateView(text: appVM.emptyTickerText)
        } else {
            EmptyView()
        }
    }
    
    private var titleToolBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(appVM.titleText)
                Text(appVM.subtitleText)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            .font(.title2.weight(.heavy))
            .padding(.vertical)
        }
    }
    
    private var attributionToolbar: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            HStack {
                Button {
                    appVM.openYahooFinance()
                } label: {
                    Text(appVM.attributionText)
                        .font(.caption.weight(.heavy))
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    
    @StateObject static var appVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = Ticker.stubs
        return vm
    }()
    
    @StateObject static var emptyAppVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = []
        return vm
    }()
    
    @StateObject static var quotesVM: QuotesViewModel = {
        let vm = QuotesViewModel()
        vm.quotesDict = Quote.stubsDict
        return vm
    }()
    
    static var previews: some View {
        Group {
            NavigationStack {
                MainListView(quotesVM: quotesVM)
            }
            .environmentObject(appVM)
            .previewDisplayName("with tickers")
            
            NavigationStack {
                MainListView(quotesVM: quotesVM)
            }
            .environmentObject(emptyAppVM)
            .previewDisplayName("with no tickers")
        }
    }
}
