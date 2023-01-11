//
//  MatchedGeometryEffectPractice2.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/11.
//

import SwiftUI

struct MatchedGeometryEffectPractice2: View {
    
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = "Home"
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { text in
                ZStack {
                    
                    if selected == text {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.red.opacity(0.5))
                            .matchedGeometryEffect(id: "category", in: namespace)
                            .frame(width: 100, height: 3)
                            .offset(y: 20)
                    }
                    
                    Text(text)
                        .foregroundColor(selected == text ? .red : .black)
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = text
                    }
                }
            }
        }
        .padding()
    }
}

struct MatchedGeometryEffectPractice2_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectPractice2()
    }
}
