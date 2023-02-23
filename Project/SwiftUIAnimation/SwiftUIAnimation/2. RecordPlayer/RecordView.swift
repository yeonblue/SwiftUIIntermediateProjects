//
//  RecordView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/23.
//

import SwiftUI

struct RecordView: View {
    
    @Binding var degress: Double
    @Binding var shouldAnimate: Bool
    
    var body: some View {
        Image("record")
            .resizable()
            .frame(width: 275, height: 275)
            .shadow(color: .gray, radius: 2, x: 0, y: 0)
            .rotationEffect(Angle.degrees(degress))
            .animation(.linear(duration: shouldAnimate ? 60 : 0).delay(1.5), value: shouldAnimate)
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(degress: .constant(90.0), shouldAnimate: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
