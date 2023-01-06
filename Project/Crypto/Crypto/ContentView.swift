//
//  ContentView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Accent Color")
                    .foregroundColor(.theme.accent)
                
                Text("Secondary Text Color")
                    .foregroundColor(.theme.secondaryText)
                
                Text("Red Color")
                    .foregroundColor(.theme.red)
                
                Text("Green Color")
                    .foregroundColor(.theme.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
