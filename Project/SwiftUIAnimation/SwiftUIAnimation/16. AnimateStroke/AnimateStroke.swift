//
//  AnimateStroke.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/10.
//

import SwiftUI

/// Background를 지은 이미지 사용
/// InkScape 같은 프로그램으로 비트맵 이미지를 벡터 이미지로 변경
/// Kite 같은 프로그램으로 스케치로 만들어진 이미지를 Swift 코드로 변경 가능

struct AnimateStroke: View {
    var body: some View {
        HeartView()
            .frame(width: 200, height: 200)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct HeartView: View {
    @State var strokeReset: Bool = true
    @State var startStroke: CGFloat = 0.0
    @State var endStroke: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            HeartShape()
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .foregroundColor(.black)
            
            HeartShape()
                .trim(from: startStroke, to: endStroke)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(.red)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
                if (endStroke >= 1) {
                    if (strokeReset) {
                        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
                            endStroke = 0
                            startStroke = 0
                            strokeReset.toggle()
                        }
                        strokeReset = false
                    }
                }
                
                withAnimation(.easeOut) {
                    endStroke += 0.1
                    startStroke = endStroke - 0.4
                }
            }
        }
    }
}

struct AnimateStroke_Previews: PreviewProvider {
    static var previews: some View {
        AnimateStroke()
    }
}
