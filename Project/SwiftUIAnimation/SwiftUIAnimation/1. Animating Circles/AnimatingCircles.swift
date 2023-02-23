//
//  AnimatingCircles.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/23.
//

import SwiftUI

struct AnimatingCircles: View {
    
    @State private var scaleInout = false
    @State private var rotateInOut = false
    @State private var moveInOut = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                
                // MARK: - Circle Set 1
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.green, .white]),
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.green, .white]),
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                
                // MARK: - Circle Set 2
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.green, .white]),
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.green, .white]),
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }
                .opacity(0.5)
                .rotationEffect(.degrees(60))
                
                // MARK: - Circle Set 3
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.green, .white]),
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.green, .white]),
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }
                .opacity(0.5)
                .rotationEffect(.degrees(120))
            }
            .rotationEffect(.degrees(rotateInOut ? 90 : 0))
            .scaleEffect(scaleInout ? 1 : 0.25)
            .animation(.easeInOut.repeatForever(autoreverses: true).speed(1/2))
            .onAppear {
                moveInOut.toggle()
                scaleInout.toggle()
                rotateInOut.toggle()
            }
        }
    }
}

struct AnimatingCircles_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingCircles()
    }
}
