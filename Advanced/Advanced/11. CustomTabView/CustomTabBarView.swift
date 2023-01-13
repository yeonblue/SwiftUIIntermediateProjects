//
//  CustomTabBarView.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/12.
//

import SwiftUI

struct CustomTabBarView: View {

    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @State var localSelection: TabBarItem
    @Namespace var backgroundNamespace
    
    var body: some View {
        tabBarVersion2
            .onChange(of: selection) { newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [.home, .favorites, .profile]
    
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBarView(tabs: tabs,
                             selection: .constant(tabs.first!),
                             localSelection: tabs.first!)
        }
    }
}

extension CustomTabBarView {
    
    private func tabView(tabItem: TabBarItem) -> some View {
        VStack {
            Image(systemName: tabItem.iconName)
                .font(.subheadline)
            Text(tabItem.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(selection == tabItem ? tabItem.color : .gray)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(selection == tabItem ? tabItem.color.opacity(0.2) : .clear)
        .cornerRadius(10)
    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tabItem: tab)
                    .onTapGesture {
                        switchToTab(tabItem: tab)
                    }
            }
        }
        .padding()
        .background(
            Color.white.ignoresSafeArea(edges: .bottom)
        )
    }
}

// MARK: - Functions
extension CustomTabBarView {
    private func switchToTab(tabItem: TabBarItem) {
        selection = tabItem
    }
}

extension CustomTabBarView {
    
    private func tabView2(tabItem: TabBarItem) -> some View {
        VStack {
            Image(systemName: tabItem.iconName)
                .font(.subheadline)
            Text(tabItem.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tabItem ? tabItem.color : .gray)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tabItem {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tabItem.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: backgroundNamespace)
                }
            }
        )
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tabItem: tab)
                    .onTapGesture {
                        switchToTab(tabItem: tab)
                    }
            }
        }
        .background(
            Color.white.ignoresSafeArea(edges: .bottom)
        )
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 0)
        .padding(.horizontal)
    }
}
