//
//  TwinkleStar.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/03/02.
//

import SwiftUI

struct TwinkleStar: View {
    
    @State private var animateYellow = false
    @State private var animateBlue = false
    @State private var animateRed = false
    @State private var animatePurple = false
    @State private var animateGreen = false
    
    @State private var starThickness: CGFloat = 0.0
    
    var starPoint = 0
    
    var body: some View {
        ZStack {
            
            // MARK: - Background image
            Image("stars")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                StarView(starPoints: 4,
                         starThickness: $starThickness,
                         animateStar: $animateYellow, fillColor: .yellow,
                         starSizeStart: 0.2, starSizeEnd: 0.4,
                         shadowColor: .yellow)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true)) {
                        animateYellow.toggle()
                        starThickness = 0.35
                    }
                }
                
                StarView(starPoints: 4,
                         starThickness: $starThickness,
                         animateStar: $animateBlue, fillColor: .blue,
                         starSizeStart: 0.2, starSizeEnd: 0.4,
                         shadowColor: .blue)
                .offset(x: 70, y: -45)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                        animateBlue.toggle()
                        starThickness = 0.35
                    }
                }
                
                StarView(starPoints: 4,
                         starThickness: $starThickness,
                         animateStar: $animateRed, fillColor: .red,
                         starSizeStart: 0.2, starSizeEnd: 0.4,
                         shadowColor: .red)
                .offset(x: -70, y: -200)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                        animateBlue.toggle()
                        starThickness = 0.35
                    }
                }
                
                StarView(starPoints: 6,
                         starThickness: $starThickness,
                         animateStar: $animatePurple, fillColor: .purple,
                         starSizeStart: 0.2, starSizeEnd: 0.4,
                         shadowColor: .purple)
                .offset(x: -70, y: 100)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                        animatePurple.toggle()
                        starThickness = 0.35
                    }
                }
                
                
                StarView(starPoints: 5,
                         starThickness: $starThickness,
                         animateStar: $animateGreen, fillColor: .green,
                         starSizeStart: 0.2, starSizeEnd: 0.4,
                         shadowColor: .green)
                .offset(x: 70, y: -120)
                .onAppear {
                    withAnimation(.easeInOut(duration: 4.5).repeatForever(autoreverses: true)) {
                        animateGreen.toggle()
                        starThickness = 0.35
                    }
                }
            }
        }
    }
}

struct CustomStar: Shape {
    let starPoints: Int
    var starThickness: CGFloat
    
    var animatableData: CGFloat {
        get { starThickness }
        set { starThickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        guard starPoints >= 3 else { return Path() }
        
        let drawPoint = CGPoint(x: rect.width / -1.2, y: rect.height / -0.5)
        var starAngle = -CGFloat.pi / 2
        
        let adjustedStarAngle = .pi * 2 / CGFloat(starPoints * 2)
        
        let pointX = drawPoint.x * starThickness
        let pointY = drawPoint.y * starThickness
        
        var path = Path()
        
        path.move(to: CGPoint(x: drawPoint.x * cos(starAngle), y: drawPoint.y * sin(starAngle)))
        
        var bottomEdge: CGFloat = 0
        
        for corner in 0..<starPoints * 2 {
            let sinAngle = sin(starAngle)
            let cosAngle = cos(starAngle)
            let bottom: CGFloat
            
            if corner.isMultiple(of: 2) { // 별의 꼭지점인 경우
                bottom = drawPoint.y * sinAngle
                path.addLine(to: CGPoint(x: drawPoint.x * cosAngle, y: bottom))
            } else {
                bottom = pointY * sinAngle
                path.addLine(to: CGPoint(x: pointX * cosAngle, y: bottom))
            }
            
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            
            starAngle += adjustedStarAngle
        }
        
        // 중앙으로 이동시키기 위한 transform 진행
        let bottomSpace = (rect.height / 2 - bottomEdge) / 2
        let transform = CGAffineTransform(translationX: drawPoint.x, y: drawPoint.y + bottomSpace)
        
        return path.applying(transform)
    }
}

struct StarView: View {
    
    var starPoints: Int
    @Binding var starThickness: CGFloat
    @Binding var animateStar: Bool
    
    var fillColor: Color
    var starSizeStart: CGFloat
    var starSizeEnd: CGFloat
    var shadowColor: Color
    
    var body: some View {
        VStack {
            CustomStar(starPoints: starPoints, starThickness: starThickness)
                .fill(fillColor)
                .frame(width: 80, height: 80)
                .scaleEffect(animateStar ? starSizeStart : starSizeEnd)
                .shadow(color: shadowColor, radius: 20, x: 3, y: 3)
        }
    }
}
struct TwinkleStar_Previews: PreviewProvider {
    static var previews: some View {
        TwinkleStar()
    }
}

/*
 .edgesIgnoringSafeArea()는 View의 여백을 무시하고, .
 ignoresSafeArea()는 Safe Area를 무시하되, View의 여백(.padding)은 유지하고 배치.
 */
