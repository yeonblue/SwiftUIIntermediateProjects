//
//  GeometryReaderPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct GeometryReaderPractice: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2 // 중간
        
        let currentX = geo.frame(in: .global).midX // 왼쪽 좌표
        return 1.0 - (currentX / maxDistance)
    }
    
    var body: some View {
        // GeometryReader { geometry in
        //     HStack(spacing: 0) { // 기본적으로 spacing이 존재하므로 0으로 설정 필요
        //         Rectangle()
        //             .fill(.red)
        //             //.frame(width: UIScreen.main.bounds.width * 0.66) portrait만 쓸거면 사용 권장
        //             .frame(width: geometry.size.width * 0.66)
        //
        //         Rectangle()
        //             .fill(.blue)
        //     }
        //     .ignoresSafeArea(.all)
        // }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.orange)
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 20),
                                              axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250) // geometryReader는 정확한 아이템의 크기를 알아야 함
                    .padding(4)
                }
            }
        }
    }
}

struct GeometryReaderPractice_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderPractice()
    }
}

/// Geometry Reader는 편리한 기능이지만 중첩되어 사용하면 UI Update가 느려지거나 할 수 있음
/// 최대한 이를 사용하지 않고 화면을 구현하는 것이 좋으며, 반드시 필요할 때만 최소한으로 사용하는 것이 좋음

/// .frame(width: UIScreen.main.bounds.width * 0.66)
/// 화면을 돌리면 height가 아닌 여전히 width로 계산 landscape로 돌릴 경우 여전히 계산은 portrait의 width로 계산
/// GeometryReader는 현재 portrait/landscape의 content size를 반환해줌
