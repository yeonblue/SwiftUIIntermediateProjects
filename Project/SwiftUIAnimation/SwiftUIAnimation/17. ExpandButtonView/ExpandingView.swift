//
//  ExpandingView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/10.
//

import SwiftUI

enum ExpandDirection {
    case bottom
    case left
    case right
    case top
    
    /// expand 되었을 때 각각 offset
    var offsets: (CGFloat, CGFloat) {
        switch self {
        case .bottom:
            return (32, 62)
        case .left:
            return (-62, 32)
        case .top:
            return (-32, -62)
        case .right:
            return (62, -32)
        }
    }
    
    /// expand 되기 전 사각형 모양을 만들기 위한 offset
    var containerOffsets: (CGFloat, CGFloat) {
        switch self {
        case .bottom:
            return (18, 18)
        case .left:
            return (-18, 18)
        case .top:
            return (-18, -18)
        case .right:
            return (18, -18)
        }
    }
}

struct ExpandingView: View {
    
    @Binding var expand: Bool
    var direction: ExpandDirection
    var symbolName: String
    
    var body: some View {
        ZStack {
            ZStack {
                Image(systemName: symbolName)
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.black)
                    .padding()
                    .scaleEffect(expand ? 1 : 0)
                    .rotationEffect(expand ? .degrees(-45) : .degrees(0))
                    .animation(.easeOut(duration: 0.2))
            }
            .frame(width: 82, height: 82)
            .background(.white)
            .cornerRadius(expand ? 41 : 0)
            .scaleEffect(expand ? 1 : 0.5)
            .offset(x: expand ? direction.offsets.0 : 0, y: expand ? direction.offsets.1 : 0)
            .rotationEffect(expand ? .degrees(45) : .degrees(0))
            .animation(.easeOut(duration: 0.3).delay(0.1))
        }
        .offset(x: direction.containerOffsets.0, y: direction.containerOffsets.1)
    }
}

struct ExpandingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ExpandingView(expand: .constant(true), direction: .bottom, symbolName: "doc.fill")

        }
    }
}
