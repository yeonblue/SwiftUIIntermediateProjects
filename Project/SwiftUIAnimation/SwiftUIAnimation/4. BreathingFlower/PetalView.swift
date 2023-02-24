//
//  PetalView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/24.
//

import SwiftUI

struct PetalView: View {
    
    @Binding var petal: Bool
    var degress: Double = 0.0
    
    var body: some View {
        Image("petal")
            .resizable()
            .frame(width: 75, height: 125)
            .rotationEffect(.degrees(petal ? degress : degress), anchor: .bottom)
            .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true),
                       value: petal)
    }
}

struct PetalView_Previews: PreviewProvider {
    static var previews: some View {
        PetalView(petal: .constant(true))
    }
}
