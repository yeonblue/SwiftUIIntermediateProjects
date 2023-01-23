//
//  SearchViewModel.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import SwiftUI
import StocksAPI
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var query: String = ""
    @Published var phase: FetchPhase<[Ticker]> = .initial
    
    var emptyListText: String {
        return "Symbols not found for\n\(query)"
    }
    
    private var trimmedQuery: String {
        return query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var tickers: [Ticker] {
        return phase.value ?? []
    }
    
    var error: Error? {
        return phase.error
    }
    
    var isSearching: Bool {
        !trimmedQuery.isEmpty
    }
    
    private let stockAPI: StockAPIService
    var cancellable = Set<AnyCancellable>()
    
    init(query: String = "", stockAPI: StockAPIService = StocksAPI()) {
        self.query = query
        self.stockAPI = stockAPI
        
        startObserving()
    }
    
    private func startObserving() {
        $query
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { _ in
                Task { [weak self] in
                    await self?.searchTickers()
                }
            }
            .store(in: &cancellable)
        
        $query
            .filter { $0.isEmpty }
            .sink { [weak self] _ in
                self?.phase = .initial
            }
            .store(in: &cancellable)
    }
    
    func searchTickers() async {
        let searchQuery = trimmedQuery
        guard !searchQuery.isEmpty else { return }
        
        phase = .fetching
        
        do {
            let tickers = try await stockAPI.searchTickers(query: searchQuery, isEquityTypeOnly: true)
            if searchQuery != trimmedQuery {
                return
            } else {
                phase = .success(tickers)
            }
        } catch {
            if searchQuery != trimmedQuery {
                return
            } else {
                phase = .failure(error)
                print(error.localizedDescription)
            }
        }
    }
}
