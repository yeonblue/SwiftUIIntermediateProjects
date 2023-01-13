//
//  AppNavBarView.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/13.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange
                    .ignoresSafeArea()
                
                CustomNavLink {
                    Text("Destination")
                        .customNavigationTitle("Second View")
                        .customNavigationSubTitle("Second SubTitle")
                } label: {
                    Text("Click Me")
                }
            }
            .customNavigationTitle("AppNavBarView")
            .customNavigationSubTitle("Subtitle")
            .customNavigationBarBackButtonHidden(true)
        }
    }
}

struct AppNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavBarView()
    }
}

extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                
                NavigationLink { // navigationView 안에서만 사용 가능
                    Text("Destination")
                        .navigationTitle("Title2")
                } label: {
                    Text("Navigation")
                }
            }
            .navigationTitle("Navitaion Title")
        }
    }
}
