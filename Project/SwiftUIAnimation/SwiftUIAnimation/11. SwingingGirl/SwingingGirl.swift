//
//  SwingingGirl.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/28.
//

import SwiftUI

struct SwingingGirl: View {
    
    @State private var girl = false
    @State private var leftLeg = false
    @State private var rightLeg = false
    
    let fadeOutRope = Gradient(colors: [.clear, .black])
    
    var body: some View {
        ZStack {
            Image("tree")
                .resizable()
                .frame(width: 550, height: 940)
            
            ZStack {
                
                // left leg
                Image("leg")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(leftLeg ? -45 : 30), anchor: .topTrailing)
                    .scaleEffect(0.12)
                    .offset(x: -455, y: 90)
                    .animation(.easeInOut(duration: 0.5).delay(1).repeatForever(autoreverses: true), value: leftLeg)
                    .zIndex(1)
                
                // right leg
                Image("leg")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(rightLeg ? -20 : 50), anchor: .topTrailing)
                    .scaleEffect(0.12)
                    .offset(x: -448, y: 90)
                    .animation(.easeInOut(duration: 1).delay(0.3).repeatForever(autoreverses: true), value: rightLeg)
                
                // girl
                Image("girl")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.25)
                    .offset(x: -300, y: 0)
                
                // rope
                Image("rope")
                    .resizable()
                    .scaledToFit()
                    .mask(LinearGradient(gradient: fadeOutRope, startPoint: .top, endPoint: .bottom))
                    .frame(width: 57, height: 80)
                    .offset(x: -228, y: -108)
                
                Image("rope")
                    .resizable()
                    .scaledToFit()
                    .mask(LinearGradient(gradient: fadeOutRope, startPoint: .top, endPoint: .bottom))
                    .frame(width: 57, height: 80)
                    .offset(x: -189, y: -100)
                
            }
            .rotationEffect(.degrees(girl ? -20 : -45), anchor: .top)
            .animation(.easeInOut(duration: 1).delay(0.3).repeatForever(autoreverses: true), value: girl)
            
            Image("leaves")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(-15), anchor: .trailing)
                .frame(width: 400, height: 400)
                .offset(x: -10, y: -180)
        }
        .onAppear {
            leftLeg.toggle()
            rightLeg.toggle()
            girl.toggle()
        }
        
        .frame(width: 950, height: 900)
    }
}

struct SwingingGirl_Previews: PreviewProvider {
    static var previews: some View {
        SwingingGirl()
    }
}
