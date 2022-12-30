//
//  DragGesturePractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/30.
//

import SwiftUI

struct DragGesturePractice: View {
    
    @State var offset: CGSize = .zero
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2 // 중간에서 시작하므로
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = Double(currentAmount / max)
        
        let maxAngle: Double = 10
        return percentage * maxAngle
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(offset.width), \(offset.height)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                offset = value.translation // CGSize로 이동거리 반환됨
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        })
            )
        }
    }
}

struct DragGesturePractice_Previews: PreviewProvider {
    static var previews: some View {
        DragGesturePractice()
    }
}
