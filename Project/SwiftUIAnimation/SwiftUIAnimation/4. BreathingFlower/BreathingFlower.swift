//
//  BreathingFlower.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/23.
//

import SwiftUI

struct BreathingFlower: View {
    
    @State private var petal = false
    @State private var breathInLabel = true
    @State private var breathOutLabel = false
    @State private var offsetBreath = false
    @State private var diffuseBreath = false
    @State private var breathTheBouquet = false
    
    var body: some View {
        ZStack {
            
            // MARK: - Background
            Image("winterNight")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 900)
                .scaleEffect(1.1) // ignoreSafeAraa는 화면이 늘어날 수 있으므로 scaleEffect 사용
            
            SnowView()
            
            ZStack {
                // MARK: - Animate text label
                Group {
                    Text("Breath In")
                        .font(.custom("papyrus", size: 35))
                        .foregroundColor(Color(uiColor: .green))
                        .opacity(breathInLabel ? 0 : 1)
                        .scaleEffect(breathInLabel ? 0 : 1)
                        .offset(y: -160)
                        .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true),
                                   value: breathInLabel)
                    
                    Text("Breath Out")
                        .font(.custom("papyrus", size: 35))
                        .foregroundColor(Color(uiColor: .orange))
                        .opacity(breathOutLabel ? 0 : 1)
                        .scaleEffect(breathOutLabel ? 0 : 1)
                        .offset(y: -160)
                        .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true),
                                   value: breathOutLabel)
                }
                
                // MARK: - Breath
                Group {
                    Image("smoke")
                        .resizable()
                        .frame(width: 35, height: 125)
                        .offset(y: offsetBreath ? 90 : 0)
                        .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true),
                                   value: offsetBreath)
                        .blur(radius: diffuseBreath ? 1 : 60)
                        .offset(y: diffuseBreath ? -50 : -100)
                        .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true),
                                   value: diffuseBreath)
                        .shadow(radius: diffuseBreath ? 20 : 0)
                }
                
                // MARK: - Animate Petals
                Group {
                    PetalView(petal: $petal, degress: petal ? -25 : -5)
                    PetalView(petal: $petal, degress: petal ? 25 : 5)
                    PetalView(petal: $petal)
                    PetalView(petal: $petal, degress: petal ? -50 : -10)
                    PetalView(petal: $petal, degress: petal ? 50 : 10)
                }
                
                // MARK: - Buuquet
                Group {
                    Image("bouquet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 400)
                        .rotationEffect(.degrees(36))
                        .offset(x: -25, y: 90)
                        .scaleEffect(breathTheBouquet ? 1.05 : 1, anchor: .center)
                        .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true),
                                   value: breathTheBouquet)
                    
                    Image("bouquet")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 400)
                        .rotationEffect(.degrees(36))
                        .offset(x: -25, y: 90)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .scaleEffect(breathTheBouquet ? 1.05 : 1, anchor: .center)
                        .hueRotation(.degrees(breathTheBouquet ? -50 : 300))
                        .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true),
                                   value: breathTheBouquet)
                }
            }
        }
        .onAppear {
            breathInLabel.toggle()
            breathOutLabel.toggle()
            offsetBreath.toggle()
            diffuseBreath.toggle()
            petal.toggle()
            breathTheBouquet.toggle()
        }
    }
}

struct BreathingFlower_Previews: PreviewProvider {
    static var previews: some View {
        BreathingFlower()
    }
}
