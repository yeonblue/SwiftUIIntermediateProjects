//
//  RotationGesturePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/30.
//

import SwiftUI

struct RotationGesturePractice: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Rotation")
            .font(.largeTitle)
            .padding(50)
            .background(Color.blue.cornerRadius(16))
            .foregroundColor(.white)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged({ value in
                        angle = value
                    })
                    .onEnded({ value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    })
            )
    }
}

struct RotationGesturePractice_Previews: PreviewProvider {
    static var previews: some View {
        RotationGesturePractice()
    }
}
