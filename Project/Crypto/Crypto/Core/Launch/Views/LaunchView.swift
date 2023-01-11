//
//  LaunchView.swift
//  Crypto
//
//  Created by yeonBlue on 2023/01/11.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map { String($0) }
    @State private var showLoadingText: Bool = false
    
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launch.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            ZStack {
                
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .foregroundColor(.launch.accent)
                                .fontWeight(.heavy)
                                .offset(y: counter == index ? -5 : 0)
                        }
                        .transition(.scale.animation(.easeIn))
                    }
                }
            }
            .offset(y: 80)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                counter += 1
                counter %= loadingText.count
                
                loops += 1
                if loops == loadingText.count * 2 {
                    showLaunchView = false
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
