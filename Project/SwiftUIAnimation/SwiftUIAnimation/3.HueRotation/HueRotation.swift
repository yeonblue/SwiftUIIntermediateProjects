//
//  HueRotation.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/23.
//

import SwiftUI

struct HueRotation: View {
    
    @State private var shiftColors = false
    @State private var imageName = "dog"
    
    let backgroundColor = Color(.black)
    
    var body: some View {
        VStack {
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                Image(imageName)
                    .resizable()
                    .padding(16)
                    .frame(width: 350, height: 350)
                    .hueRotation(.degrees(shiftColors ? 360 * 2 : 0))
                    .animation(.easeInOut(duration: 2).delay(0.4).repeatForever(autoreverses: true),value: shiftColors)
                    .onAppear {
                        shiftColors.toggle()
                    }
            }
            
            HueImagePicker(selectedImage: $imageName)
        }
        .background(backgroundColor)
    }
}

struct HueImagePicker: View {
    @Binding var selectedImage: String
    let images: [String] = ["ornament", "landscape", "dog", "dice", "cat"]
    
    var body: some View {
        Picker("", selection: $selectedImage) {
            ForEach(images, id: \.self) { image in
                Text(image)
                    .foregroundColor(.white)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 300, height: 150)
        .background(Color.red.colorMultiply(.blue))
        .cornerRadius(20)
        .shadow(color: .white, radius: 4, x: 0, y: 0)
    }
}

struct HueRotation_Previews: PreviewProvider {
    static var previews: some View {
        HueRotation()
    }
}
