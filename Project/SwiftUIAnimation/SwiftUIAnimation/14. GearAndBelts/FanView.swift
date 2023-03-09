//
//  FanView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/09.
//

import SwiftUI

struct FanView: View {
    
    @State var rotateFan: Bool = false
    var degrees: Double = 360 * 4
    
    var body: some View {
        ZStack {
            Image("fan")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .rotationEffect(.degrees(rotateFan ? degrees : 0), anchor: .center)
                .shadow(color: .black, radius: 8, x: 0, y: 0)
                .animation(.linear(duration: 4).repeatForever(autoreverses: false), value: rotateFan)
        }
        .onAppear {
            rotateFan.toggle()
        }
    }
}

struct FanView_Previews: PreviewProvider {
    static var previews: some View {
        FanView()
    }
}
