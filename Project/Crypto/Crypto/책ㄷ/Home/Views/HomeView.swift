//
//  HomeView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/06.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showProtfolio: Bool = false
    
    var body: some View {
        ZStack {
            
            // background
            Color.theme.background
                .ignoresSafeArea()
            
            // content
            VStack {

                homeHeaderView
                
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
}

