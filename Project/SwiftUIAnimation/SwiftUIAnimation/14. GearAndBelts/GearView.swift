//
//  GearView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/09.
//

import SwiftUI

struct GearView: View {
    
    @State private var rotateGear = false
    var gearImage: String = ""
    var gearWidth: CGFloat = 0.0
    var gearDegrees: Double = 0.0
    var offsetGearX: CGFloat = 0.0
    var offsetGearY: CGFloat = 0.0
    var rotateDegrees: Double = 0.0
    var duration: Double = 0.0
    var xAxis: CGFloat = 0.0
    var yAxis: CGFloat = 0.0
    var zAxis: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Image(gearImage)
                .resizable()
                .scaledToFit()
                .frame(width: gearWidth)
                .rotationEffect(.degrees(rotateGear ? gearDegrees : 0))
                .rotation3DEffect(.degrees(rotateDegrees), axis: (x: xAxis, y: yAxis, z: zAxis))
                .offset(x: offsetGearX, y: offsetGearY)
                .animation(.linear(duration: duration).repeatForever(autoreverses: false), value: rotateGear)
        }
        .shadow(color: .black, radius: 2, x: 0, y: 0)
        .onAppear {
            rotateGear.toggle()
        }
    }
}

struct GearView_Previews: PreviewProvider {
    static var previews: some View {
        GearView(gearImage: "doubleGear",
                 gearWidth: 300, gearDegrees: 360,
                 offsetGearX: 0, offsetGearY: 0,
                 duration: 5)
    }
}
