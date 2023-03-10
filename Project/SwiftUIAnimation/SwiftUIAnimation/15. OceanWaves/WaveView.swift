//
//  WaveView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/09.
//

import SwiftUI

struct WaveView: Shape {
    
    var animatableData: CGFloat {
        get { return yOffset }
        set { yOffset = newValue }
    }
    
    var yOffset: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero) // 좌측 상단
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        // to는 곡선의 끝점. 두개의 control point는 해당 지점을 기준으로 커브를 생성
        // 제어점을 사용하여 곡선의 모양을 결정하기 때문에 control1과 control2가 같은 값이어도 곡선이 생길 수 있음.
        // https://developer.apple.com/documentation/uikit/uibezierpath/1624357-addcurve 참고
        path.addCurve(to: CGPoint(x: rect.minY, y: rect.minY),
                      control1: CGPoint(x: rect.maxX * 0.45, y: rect.minY - (rect.maxY * yOffset)),
                      control2: CGPoint(x: rect.maxX * 0.45, y: (rect.maxY * yOffset)))
        path.closeSubpath()
        
        return path
    }
}

struct WaveView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WaveView(yOffset: 0.7)
                .stroke(.blue, lineWidth: 3)
                .frame(height: 250)
                .padding()
                .previewDisplayName("Wave")
        }
    }
}
