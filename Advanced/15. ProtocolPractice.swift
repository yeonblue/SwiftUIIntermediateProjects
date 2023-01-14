//
//  ProtocolPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/14.
//

import SwiftUI

struct ProtocolPractice: View {
    
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonTextProtocol
    
    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.ButtonPressed()
                }
        }
    }
}

struct ProtocolPractice_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolPractice(colorTheme: DefaultColorTheme(),
                         dataSource: AlternativeDataSource())
    }
}


protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

struct DefaultColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secondary: Color = .white
    var tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    var primary: Color = .red
    var secondary: Color = .orange
    var tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    
    var primary: Color = .blue
    var secondary: Color = .red
    var tertiary: Color = .purple
}


protocol ButtonTextProtocol {
    var buttonText: String { get }
    func ButtonPressed()
}

class DefaultDataSource: ButtonTextProtocol, AdditionalProtocol {
    
    var buttonText: String = "Protocol Practice"
    
    
    func ButtonPressed() {
        print("DefaultDataSource Tapped")
    }
    
    func defaultFuction() {
        
    }
    
    func additional() {
        
    }
}

class AlternativeDataSource: ButtonTextProtocol {
    
    var buttonText: String = "Protocol Awesome!"
    
    func ButtonPressed() {
        print("AlternativeDataSource Tapped")
    }
    
    func alternativeFunction() {
        
    }
}

protocol AdditionalProtocol {
    func additional()
}
