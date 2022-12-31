//
//  ScrollViewReaderPractice.swift
//  Intermediate
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

struct ScrollViewReaderPractice: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            
            TextField("Enter a #row...", text: $textFieldText)
                .frame(height: 55)
                .border(.gray)
                .padding()
                .keyboardType(.numberPad)
            
            Button {
                withAnimation(.spring()) {
                    guard let index = Int(textFieldText) else { return }
                    scrollToIndex = index
                }
            } label: {
                Text("Go to row #")
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                
                ScrollViewReader { proxy in // scrollView 안에서 사용
                    ForEach(0..<50) {index in
                        Text("Row #\(index)")
                            .font(.headline)
                            .frame(height: 100)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                            .id(index) // id를 반드시 주어야 함
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(scrollToIndex, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaderPractice_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderPractice()
    }
}
