//
//  CustomShapePractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/11.
//

import SwiftUI

struct CustomShapePractice: View {
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
    
                Image("swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(
                        Trapezoid()
                    )
                
                Diamond()
                //.stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
                    .fill(
                        LinearGradient(colors: [.red, .blue],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(width: 300, height: 300)
            }
        }
    }
}

struct CustomShapePractice_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapePractice()
    }
}

struct Triangle: Shape { // shape은 path를 가짐
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: 0))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            let horizentalOffset = rect.width * 0.2
            
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: CGPoint(x: horizentalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX - horizentalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: 0))
        }
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            let horizentalOffset = rect.width * 0.2
            
            path.move(to: CGPoint(x: horizentalOffset, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.maxY))
            path.addLine(to: CGPoint(x: horizentalOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX - horizentalOffset, y: 0))
        }
    }
}
