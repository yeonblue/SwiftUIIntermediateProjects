//
//  EmptyStateView.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import SwiftUI

struct EmptyStateView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .font(.headline)
                .foregroundColor(Color(uiColor: .secondaryLabel))
            Spacer()
        }
        .padding(64)
        .lineLimit(3)
        .multilineTextAlignment(.center)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(text: "No Data")
    }
}
