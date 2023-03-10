//
//  BuoyView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/10.
//

import SwiftUI

struct BuoyView: View {
    
    @Binding var tiltForwardBackward: Bool
    @Binding var upAndDown: Bool
    @Binding var leadingAnchorAnimation: Bool
    
    @State private var red = 1.0
    @State private var green = 1.0
    @State private var blue = 1.0
    
    let cornerRadius = 8.0
    
    var body: some View {
        ZStack {
            Image("buoy")
                .overlay(
                    Rectangle()
                        .fill(Color(red: red, green: green, blue: blue))
                        .frame(width: 12, height: 17)
                        .padding(.bottom, cornerRadius)
                        .cornerRadius(cornerRadius)
                        .padding(.bottom, -cornerRadius)
                        .position(x: 112.5, y: 19.5)
                        .animation(.easeOut(duration: 1).repeatForever(autoreverses: true), value: red)
                    
                    // 아래와 같이 편법으로 위에만 CornerRadius를 줄 수 있음
                    // .padding(.bottom, cornerRadius)
                    // .cornerRadius(cornerRadius)
                    // .padding(.bottom, -cornerRadius)
                )
                .rotationEffect(.degrees(leadingAnchorAnimation ? 8 : -4), anchor: .leading)
                .animation(.easeOut(duration: 1).repeatForever(autoreverses: true), value: leadingAnchorAnimation)
                .rotationEffect(.degrees(tiltForwardBackward ? -20 : 15))
                .animation(.easeOut(duration: 1.0).delay(0.2).repeatForever(autoreverses: true), value: tiltForwardBackward)
                .offset(y: upAndDown ? -10 : 10)
        }
        .onAppear {
            red = 0.5
            green = 0.5
            blue = 0.5
            
            leadingAnchorAnimation.toggle()
            tiltForwardBackward.toggle()
            upAndDown.toggle()
        }
    }
}

struct BuoyView_Previews: PreviewProvider {
    static var previews: some View {
        BuoyView(tiltForwardBackward: .constant(true),
                 upAndDown: .constant(true),
                 leadingAnchorAnimation: .constant(true))
    }
}
