//
//  ButtonStylePractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/06.
//

import SwiftUI

// TapGesture는 Highlight가 없기에 Button을 선호
// Highlight 등은 커스터마이징이 가능

struct ButtonStylePractice: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("Click Me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(8)
                    .shadow(radius: 8)
            }
            //.buttonStyle(.plain) // highlight가 .default 보다는 강하지 않음
            .withPressableStyle(scaleAmount: 0.85)
        }
        .padding()
        
    }
}

struct ButtonStylePractice_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStylePractice()
    }
}

struct PressableButtonStyle: ButtonStyle {
    
    let scaleAmount: Double
    
    init(scaleAmount: Double = 0.9) {
        self.scaleAmount = scaleAmount
    }
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            //.brightness(configuration.isPressed ? 0.2 : 0.0)
            //.opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}

extension View {
    func withPressableStyle(scaleAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaleAmount: scaleAmount))
    }
}
