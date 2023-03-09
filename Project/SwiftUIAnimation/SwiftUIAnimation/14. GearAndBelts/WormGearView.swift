//
//  WormGearView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/09.
//

import SwiftUI

struct WormGearView: View {
    
    @State private var rect1 = false
    @State private var rect2 = false
    @State private var rect3 = false
    @State private var rect4 = false
    
    var body: some View {
        ZStack {
            ZStack {
                Image("wormGear")
                    .resizable()
                    .frame(width: 100, height: 75)
                
                // 회전하면서 틈 사이에 사각형을 표시해서 기어가 도는 것처럼 보이기 위함
                HStack {
                    Rectangle()
                        .modifier(RectModifiers())
                        .opacity(rect1 ? 0 : 0.3)
                        .offset(x: 2, y: rect1 ? 14: -8)
                        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: rect1)
                        .rotationEffect(.degrees(-4), anchor: .trailing) // 음수므로 시계 반대방향
                        .onAppear {
                            rect1.toggle()
                        }
                    
                    Rectangle()
                        .modifier(RectModifiers())
                        .opacity(rect2 ? 0 : 0.3)
                        .offset(x: 7, y: rect2 ? -15 : -8)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: rect2)
                        .rotationEffect(.degrees(-8))
                        .onAppear(){
                            rect2.toggle()
                        }

                    Rectangle()
                        .modifier(RectModifiers())
                        .opacity(rect3 ? 0 : 0.3)
                        .offset(x: 5, y: rect3 ? -5 : -10)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: rect3)
                        .rotationEffect(.degrees(-8), anchor: .top)
                        .onAppear(){
                            rect3.toggle()
                        }

                    Rectangle()
                        .modifier(RectModifiers())
                        .opacity(rect4 ? 0 : 0.3)
                        .offset(x: 4, y: rect4 ? -10 : -10)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: rect4)
                        .rotationEffect(.degrees(-7), anchor: .top)
                        .onAppear(){
                            rect4.toggle()
                       }
                }
            }
            .shadow(color: .black, radius: 1, x: 0, y: 1)
        }
    }
}

struct RectModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 4, height: 40)
            .foregroundColor(.black)
            .cornerRadius(5)
    }
}

struct WormGearView_Previews: PreviewProvider {
    static var previews: some View {
        WormGearView()
    }
}
