//
//  SearchView.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import SwiftUI
import StocksAPI

struct SearchView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    @ObservedObject var searchVM: SearchViewModel
    
    var body: some View {
        List(searchVM.tickers) { ticker in
            TickerListRowView(data: TickerListRowData(
                symbol: ticker.symbol,
                name: ticker.shortName,
                price: quotesVM.priceForTicker(ticker),
                type: .search(isSaved: appVM.isAddedToMyTickers(ticker: ticker),
                              onButtonTapped: {
                                  appVM.toggleTicker(ticker)
                              })))
            //.contentShape(Rectangle())
            //.onTapGesture {
            //
            //}
        }
        .listStyle(.plain)
        .overlay {
            listSearchOverlay
        }
        .task(id: searchVM.tickers) {
            await quotesVM.fetchQuotes(tickers: searchVM.tickers)
        }
        .refreshable {
            await quotesVM.fetchQuotes(tickers: searchVM.tickers)
        }
    }
    
    @ViewBuilder
    private var listSearchOverlay: some View {
        switch searchVM.phase {
            case .failure(let error):
                ErrorStateView(error: error.localizedDescription) {
                    Task {
                        await searchVM.searchTickers()
                    }
                }
            case .empty:
                EmptyStateView(text: searchVM.emptyListText)
            case .fetching:
                LoadingStateView()
            default:
                EmptyView()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    @StateObject static var stubbedSearchVM: SearchViewModel = {
        
        var mock = MockStocksAPI()
        mock.stubbedSearchTickersCallback = { Ticker.stubs }
        
        let vm = SearchViewModel(query: "Apple", stockAPI: mock)
        vm.phase = .success(Ticker.stubs)
        return vm
    }()
    
    @StateObject static var emptySearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.phase = .empty
        return vm
    }()
    
    @StateObject static var errorSearchVM: SearchViewModel = {
        let vm = SearchViewModel()
        vm.phase = .failure(URLError(.badServerResponse))
        return vm
    }()
    
    @StateObject static var appVM: AppViewModel = {
        let vm = AppViewModel()
        vm.tickers = Ticker.stubs
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
                SearchView(quotesVM: quotesVM, searchVM: stubbedSearchVM)
            }
            .searchable(text: $stubbedSearchVM.query)
            .previewDisplayName("Results")
            
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: emptySearchVM)
            }
            .searchable(text: $emptySearchVM.query)
            .previewDisplayName("Empty Results")
            
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: errorSearchVM)
            }
            .searchable(text: $errorSearchVM.query)
            .previewDisplayName("Error Results")
        }
        .environmentObject(appVM)
    }
}
