//
//  CustomNavBarView.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/13.
//

import SwiftUI

struct CustomNavBarView: View {
    
    @Environment(\.dismiss) var dismiss
    var showBackButton: Bool
    var title: String
    var subTitle: String?
    
    var body: some View {
        HStack {
            
            if showBackButton {
                backButton
            }

            Spacer()
            titleSectionView
            Spacer()
            
            if showBackButton {
                backButton
                 .opacity(0.0)
            }
        }
        .frame(minHeight: 60)
        .tint(.white)
        .foregroundColor(.white)
        .font(.headline)
        .padding()
        .background(Color.blue.ignoresSafeArea(edges: .top))
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(showBackButton: false, title: "Title")
            Spacer()
        }
    }
}

extension CustomNavBarView {
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSectionView: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            
            if let subTitle = subTitle {
                Text(subTitle)
            }
        }
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom을 했기에 이를 제거하지 않으면 swipe로 pop이 불가능
        interactivePopGestureRecognizer?.delegate = nil
    }
}
