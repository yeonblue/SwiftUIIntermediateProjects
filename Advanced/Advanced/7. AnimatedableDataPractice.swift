//
//  AnimatedableDataPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/11.
//

import SwiftUI

struct AnimatedableDataPractice: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                RectangleWithSingleCornerAnimation(cornerRadius: animate ? 100 : 0)
                    .fill(.green)
                    .frame(width: 250, height: 250)
                
                PacmanShape(offsetAmount: animate ? 30 : 0)
                    .fill(.yellow)
                    .frame(width: 250, height: 250)
            }

        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct AnimatedableDataPractice_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedableDataPractice()
    }
}

struct RectangleWithSingleCornerAnimation: Shape {
    
    var cornerRadius: CGFloat
    var animatableData: CGFloat {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            path.addLine(to: CGPoint(x: rect.maxX, y: 0))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius,
                                        y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.minY, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: 0))
            
        }
    }
}

struct PacmanShape: Shape {
    
    var offsetAmount: CGFloat
    var animatableData: CGFloat {
        get { offsetAmount }
        set { offsetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.width / 2,
                        startAngle: Angle(degrees: offsetAmount),
                        endAngle: Angle(degrees: 360 - offsetAmount),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        }
    }
}
