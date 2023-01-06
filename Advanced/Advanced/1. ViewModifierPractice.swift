//
//  ViewModifierPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/06.
//

import SwiftUI

struct ViewModifierPractice: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                //.font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(8)
            
            Text("Hello, Modifier!")
                .font(.headline) // 이런 것들은 따로 빼놓는 것이 좋음
                .modifier(DefaultButtonViewModifier(backgroundColor: .orange))
            
            Text("Hello, Modifier!")
                .font(.footnote)
                .withDefaultsButtonFormatting(backgroundColor: .red)
            
            Text("Hello, Modifier!")
                .font(.footnote)
                .withDefaultsButtonFormatting()
        }
        .padding()
    }
}

struct ViewModifierPractice_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierPractice()
    }
}

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            //.font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(8)
    }
}

extension View {
    
    func withDefaultsButtonFormatting(backgroundColor: Color = . blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}
