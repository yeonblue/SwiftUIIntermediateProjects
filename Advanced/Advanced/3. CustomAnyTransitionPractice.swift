//
//  CustomAnyTransitionPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/11.
//

import SwiftUI

struct CustomAnyTransitionPractice: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.green)
                    .frame(width: 250, height: 350)
                // 애니메이션이 roundrectangle에서 시작하는 것이 아니라, 전체 크기에서 시작되게 하기 위함.
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.transition(.rotating.animation(.easeInOut))
                // remove 될 때는 금방 사라짐
                //.transition(.rotating(amount: 720).animation(.easeInOut(duration: 3)))
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Text("Click Me")
                .withDefaultsButtonFormatting()
                .padding()
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

struct CustomAnyTransitionPractice_Previews: PreviewProvider {
    static var previews: some View {
        CustomAnyTransitionPractice()
    }
}

struct RotateViewModifier: ViewModifier {
    
    let rotaionDegree: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotaionDegree))
            .offset(x: rotaionDegree != 0 ? UIScreen.main.bounds.width : 0,
                    y: rotaionDegree != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        return .modifier(active: RotateViewModifier(rotaionDegree: 180),
                         identity: RotateViewModifier(rotaionDegree: 0))
    }
    
    static func rotating(amount: Double) -> AnyTransition {
        return .modifier(active: RotateViewModifier(rotaionDegree: amount),
                         identity: RotateViewModifier(rotaionDegree: 0))
    }
    
    static var rotateOn: AnyTransition {
        return .asymmetric(insertion: .rotating,
                           removal: .move(edge: .leading))
    }
}
