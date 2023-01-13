//
//  TabViewPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/12.
//

import SwiftUI

struct TabViewPractice: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.green
                .tabBarItem(tab: .home, selection: $tabSelection)
            
            Color.orange
                .tabBarItem(tab: .favorites, selection: $tabSelection)
            
            Color.yellow
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
    }
}

struct TabViewPractice_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [.home, .favorites, .profile]
    
    static var previews: some View {
        TabViewPractice()
    }
}

extension TabViewPractice {
    
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
