//
//  PortfolioView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/09.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoListView
                    
                    if selectedCoin != nil {
                        portfolioInputSectionView
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton(presentaionMode: _presentationMode)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeViewModel)
    }
}

// MARK: - Functions
extension PortfolioView {
    private func getCurrentValue() -> Double {
        if let quntitiy = Double(quantityText) {
            return quntitiy * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0
    }
    
    private func saveButtonTapped() {
        guard let coin = selectedCoin else { return }
        
        // save to portfolio
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelection()
        }
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            withAnimation(.easeIn) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelection() {
        selectedCoin = nil
        viewModel.searchText = ""
        UIApplication.shared.endEditing()
    }
}

// MARK: - Views
extension PortfolioView {
    private var coinLogoListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green
                                                                    : Color.clear,
                                        lineWidth: 2)
                        )
                }
                .padding(.vertical, 4)
            }
            .padding(.leading)
        }
    }
    
    private var portfolioInputSectionView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrenyWith6Decimals() ?? "")
            }
            
            Divider()
            
            HStack {
                Text("Acount Holding:")
                Spacer()
                TextField("Ex: 1.5", text: $quantityText)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
            
            Divider()
            
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrenyWith6Decimals())
            }
        }
        .padding()
        .font(.headline)
        .animation(.none)
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
                .foregroundColor(.theme.green)
            
            Button {
                saveButtonTapped()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil
                 && selectedCoin?.currentHoldings != Double(quantityText) ?
                 1.0 : 0.0)
            )
        }
        .font(.headline)
    }
}
