//
//  OceanWaves.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/09.
//

import SwiftUI

struct OceanWaves: View {
    
    @State private var animateOffset = false
    @State var upAndDown = false
    @State var tiltForwardBackward = false
    @State var leadingAnchorAniate = false
    
    var body: some View {
        ZStack {
            Color.blue
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            //MARK: - WAVE 1
            WaveCreationView(animateOffset: $animateOffset, curveOne: 0.05, curveTwo: -0.05, radius: 50, shadowX: 0, shadowY: 50, duration: 5.0)
                .opacity(0.8)
                .offset(y: 575)
            
            //MARK: - BUOY
            BuoyView(tiltForwardBackward: $tiltForwardBackward, upAndDown: $upAndDown, leadingAnchorAnimation: $leadingAnchorAniate)
                .offset(y: 140)
            
            //MARK: - WAVE 2
            WaveCreationView(animateOffset: $animateOffset, curveOne: -0.07, curveTwo: 0.07, radius: 100, shadowX: 0, shadowY: 10, duration: 4.0)
                .offset(y: 610)
            
            //MARK: - WAVE 3
            WaveCreationView(animateOffset: $animateOffset, curveOne: 0.1, curveTwo: -0.1, radius: 30, shadowX: 0, shadowY: 0, duration: 3.7)
                .offset(y: 645)
            
            //MARK: - WAVE 4
            WaveCreationView(animateOffset: $animateOffset, curveOne: 0.14, curveTwo: -0.1, radius: 70, shadowX: 0, shadowY: 10, duration: 3.5)
                .offset(y: 705)
            
            //MARK: - WAVE 5
            WaveCreationView(animateOffset: $animateOffset, curveOne: -0.05, curveTwo: 0.08, radius: 60, shadowX: 0, shadowY: 20, duration: 3.2)
                .opacity(0.8)
                .offset(y: 740)
            
            //MARK: - WAVE 6
            WaveCreationView(animateOffset: $animateOffset, curveOne: -0.05, curveTwo: 0.08, radius: 60, shadowX: 0, shadowY: 20, duration: 3.4)
                .offset(y: 800)
        }
        .onAppear() {
            animateOffset.toggle()
            playSound(sound: "buoyBells", type: "m4a")
        }.onDisappear() {
            audioPlayer?.stop()
        }
    }
}

struct WaveCreationView: View {
    
    @Binding var animateOffset: Bool
    
    var curveOne: CGFloat
    var curveTwo: CGFloat
    var radius: CGFloat
    var shadowX: CGFloat
    var shadowY: CGFloat
    var duration: Double
    
    var body: some View {
        WaveView(yOffset: animateOffset ? curveOne: curveTwo)
            .fill(Color(uiColor: .blue))
            .shadow(color: .gray, radius: radius, x: shadowX, y: shadowY)
            .animation(.easeInOut(duration: duration).repeatForever(autoreverses: true), value: animateOffset)
    }
}

struct OceanWaves_Previews: PreviewProvider {
    static var previews: some View {
        OceanWaves()
    }
}
