//
//  ContentView.swift
//  PerformanceSandBox
//
//  Created by yeonBlue on 2023/01/29.
//

import SwiftUI
import Combine

class Debounce<T>: ObservableObject {

    @Published var input: T
    @Published var output: T
    
    private var debounce: AnyCancellable?
    
    init(initialValue: T, delay: Double = 0.5) {
        self.input = initialValue
        self.output = initialValue
        
        debounce = $input
            .debounce(for: .seconds(delay), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.output = $0
            })
    }
}

struct ContentView: View {
    
    @StateObject private var text = Debounce(initialValue: "", delay: 0.5)
    @StateObject private var slider = Debounce(initialValue: 0.0, delay: 0.1)
    
    var body: some View {
        VStack {
            TextField("Search for something", text: $text.input)
            Text(text.output)
            
            Spacer()
                .frame(height: 50)
            
            Slider(value: $slider.input, in: 0...100)
            Text(slider.output.formatted())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
