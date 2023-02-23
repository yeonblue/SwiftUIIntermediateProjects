//
//  ArmView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/23.
//

import SwiftUI

struct ArmView: View {
    
    @Binding var rotateArm: Bool
    
    var body: some View {
        Image("playerArm")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .shadow(color: .gray, radius: 2, x: 0, y: 0)
            .rotationEffect(.degrees(-35), anchor: .topTrailing) // ancher를 기준으로 각도만큼 회전
            .rotationEffect(.degrees(rotateArm ? 8 : 0), anchor: .topTrailing)
            .animation(.linear(duration: 2), value: rotateArm)
            .offset(x: 70, y: -250)
    }
}

struct ArmView_Previews: PreviewProvider {
    static var previews: some View {
        ArmView(rotateArm: .constant(false))
    }
}
