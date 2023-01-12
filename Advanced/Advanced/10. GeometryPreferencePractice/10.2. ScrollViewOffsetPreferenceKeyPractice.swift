//
//  ScrollViewOffsetPreferenceKeyPractice.swift
//  Advanced
//
//  Created by yeonBlue on 2023/01/12.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollViewOffsetPreferenceKeyPractice: View {
    
    let title: String = "New title here!!"
    @State private var scrollViewOffset: CGFloat = 0.0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayerView
                    .onScrollViewOffsetChange(action: { value in
                        self.scrollViewOffset = value
                    })
                
                contentLayerView
            }
            .padding()
        }
        .overlay(navBarLayerView.opacity(scrollViewOffset < 40 ? 1.0 : 0.0),
                 alignment: .top)
        .overlay(Text("\(scrollViewOffset)"))
    }
}

struct ScrollViewOffsetPreferenceKeyPractice_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetPreferenceKeyPractice()
    }
}

extension ScrollViewOffsetPreferenceKeyPractice {
    
    private var titleLayerView: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayerView: some View {
        ForEach(0..<100) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(.red.opacity(0.5))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayerView: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.blue)
    }
}

extension View {
    func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self.background(
            GeometryReader { geo in
                Text("")
                    .preference(key: ScrollViewOffsetPreferenceKey.self,
                                value: geo.frame(in: .global).minY)
            }
        )
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            action(value)
        }
    }
}
