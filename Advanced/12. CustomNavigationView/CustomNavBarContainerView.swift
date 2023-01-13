//
//  CustomNavBarContainerView.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/13.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    
    let content: Content
    
    @State private var showBackButton: Bool = true
    @State private var title: String = "Title"
    @State private var subTitle: String? = "SubTitle"
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, subTitle: subTitle)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self) { title in
            self.title = title
        }
        .onPreferenceChange(CustomNavBarSubTitlePreferenceKey.self) { subTitle in
            self.subTitle = subTitle
        }
        .onPreferenceChange(CustomNavBarHiddenBackButtonPreferenceKey.self) { showBackButton in
            self.showBackButton = !showBackButton
        }
    }
}

struct CustomNavBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainerView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                
                Text("CustomNavBarContainerView")
            }
        }
    }
}
