//
//  ParallaxEffect.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/27.
//

import SwiftUI

struct ParallaxEffect: View {
    
    @State private var animate1 = false
    @State private var animate2 = false
    
    var body: some View {
        ZStack {
            
            // MARK: - Background
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .colorInvert() // 배경색과 전경색이 반전 - 검정색 배경에 흰색 텍스트가 있는 뷰는 흰색 배경에 검정색 텍스트를 가진 뷰로 바뀜
            .ignoresSafeArea(.all)
            
            // MARK: - Contents
            VStack {
                Text("Parallax Effect")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 80)
                
                VStack {
                    Image("wolf")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                        .shadow(color: .black, radius: 30, x: 5, y: 5)
                }
                .rotation3DEffect(.degrees( animate1 ? 13 : -13),
                                  axis: (x: animate1 ? 90 : -45,
                                         y: animate1 ? -45 : -90,
                                         z: 0))
                .padding(16)
                .animation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true), value: animate1)
                
                VStack {
                    Image("cube")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                        .shadow(color: .black, radius: 30, x: 5, y: 5)
                }
                .rotation3DEffect(.degrees( animate2 ? 13 : -13),
                                  axis: (x: animate2 ? 90 : -45,
                                         y: animate2 ? -45 : -90,
                                         z: 0))
                .padding(16)
                .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: animate2)
            }
        }
        .onAppear {
            animate1.toggle()
            animate2.toggle()
        }
    }
}

struct ParallaxEffect_Previews: PreviewProvider {
    static var previews: some View {
        ParallaxEffect()
    }
}
