//
//  MaskPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct MaskPractice: View {
    
    @State var rating: Int = 3
    
    var body: some View {
        ZStack {
            StarsView(rating: $rating)
                .overlay(
                    GeometryReader { geometry in
                        Rectangle()
                            .foregroundColor(.yellow)
                            .frame(width: CGFloat(rating) / 5 * geometry.size.width)
                    }
                    .allowsHitTesting(false) // 아래 뷰를 터치 가능하도록
                    .mask(StarsView(rating: $rating))
                )
        }
    }
}

struct MaskPractice_Previews: PreviewProvider {
    static var previews: some View {
        MaskPractice()
    }
}

struct StarsView: View {
    
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(index <= rating ? .yellow : .gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
}
