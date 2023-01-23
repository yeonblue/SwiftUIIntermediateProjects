//
//  ErrorStateView.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/23.
//

import SwiftUI

struct ErrorStateView: View {
    
    let error: String
    var retryCallback: (() -> ())?
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                Text(error)
                if let retryCallback {
                    Button("Retry", action: retryCallback)
                        .buttonStyle(.borderedProminent)
                }
            }
            Spacer()
        }
        .padding(64)
    }
}

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorStateView(error: "An Error Occured", retryCallback: {})
                .previewDisplayName("with RetryButton")
            
            ErrorStateView(error: "An Error Occured")
                .previewDisplayName("No Retry Button")
        }
    }
}
