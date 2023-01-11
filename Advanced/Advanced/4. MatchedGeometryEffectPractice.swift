//
//  MatchedGeometryEffectPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/11.
//

import SwiftUI

// matchedGeometryEffect를 사용하려면 먼저 선언을 하고 크기나 이런 것들을 아래에 지정해야 함
// Namespace를 사용하여 두 개의 다른 도형을 같은 도형으로 지정하여, 애니메이션을 줄 수 있음

struct MatchedGeometryEffectPractice: View {
    
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            
            if !isClicked {
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)

            }
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 24)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffectPractice_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectPractice()
    }
}
