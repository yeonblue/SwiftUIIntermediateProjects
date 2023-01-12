//
//  GeometryPreferencePractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/12.
//

import SwiftUI

struct GeometryPreferencePractice: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .frame(width: rectSize.width, height: rectSize.height)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .background(.blue)
            
            Spacer()
            
            HStack {
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
                }
                Rectangle()
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometryPreferenceKey.self, perform: { size in
            self.rectSize = size
        })
        .padding()
    }
}

struct GeometryPreferencePractice_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferencePractice()
    }
}

struct RectangleGeometryPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometryPreferenceKey.self, value: size)
    }
}
