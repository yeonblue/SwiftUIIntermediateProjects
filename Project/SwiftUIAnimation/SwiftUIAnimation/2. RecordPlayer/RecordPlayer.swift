//
//  RecordPlayer.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/23.
//

import SwiftUI

struct RecordPlayer: View {
    
    @State private var rotateRecord = false
    @State private var rotateArm = false
    @State private var shouldAnimate = false
    @State private var degrees = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.white, .black]),
                           center: .center,
                           startRadius: 20,
                           endRadius: 600)
            .edgesIgnoringSafeArea(.all)
            
            // MARK: - Record Player Box
            RecordPlayerBox()
                .offset(y: -100)
            
            VStack {
                
                // MARK: - Record
                RecordView(degress: $degrees, shouldAnimate: $shouldAnimate)
                
                // MARK: - ArmView
                ArmView(rotateArm: $rotateArm)
                
                // MARK: - Button
                Button {
                    shouldAnimate.toggle()
                    rotateArm.toggle()
                    
                    if shouldAnimate {
                        degrees = 36000
                        playSound(sound: "music", type: "m4a")
                    } else {
                        degrees = 0
                        audioPlayer?.stop()
                    }
                } label: {
                    HStack(spacing: 8) {
                        if !shouldAnimate {
                            Text("Play")
                            Image(systemName: "play.circle.fill")
                                .imageScale(.large)
                        } else {
                            Text("Stop")
                            Image(systemName: "stop.fill")
                                .imageScale(.large)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(.white))
                    .overlay(
                        Capsule()
                            .strokeBorder(Color.black, lineWidth: 3)
                    )
                }
            }
        }
    }
}

struct RecordPlayer_Previews: PreviewProvider {
    static var previews: some View {
        RecordPlayer()
    }
}
