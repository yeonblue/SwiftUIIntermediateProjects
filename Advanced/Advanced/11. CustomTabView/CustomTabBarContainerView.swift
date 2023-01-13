//
//  CustomTabBarContainerView.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/12.
//

import SwiftUI

// struct TabView<SelectionValue, Content> : View where SelectionValue : Hashable, Content : View



struct CustomTabBarContainerView<Content: View> : View {
    
    @State private var tabs: [TabBarItem] = []
    @Binding var selection: TabBarItem
    let content: Content
    
    public init(selection: Binding<TabBarItem>, @ViewBuilder _ content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .onPreferenceChange(TabBarItemPreferenceKey.self) { value in
            tabs += value
        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [.home, .favorites, .profile]
    
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
