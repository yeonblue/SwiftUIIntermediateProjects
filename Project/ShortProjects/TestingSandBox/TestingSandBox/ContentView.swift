//
//  ContentView.swift
//  TestingSandBox
//
//  Created by yeonBlue on 2023/01/30.
//

import SwiftUI

class DataModel: ObservableObject {
    
    @Published var flag = false
    @Published var names = ["Empty"]
    
    func goingtoFail() throws {
        throw CocoaError(.fileNoSuchFile)
    }
    
    func goingToFail() async throws {
        try await Task.sleep(for: .milliseconds(500))
        throw CocoaError(.fileNoSuchFile)
    }
    
    @discardableResult
    func loadData() -> Task<Void, Never> {
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            names = ["John", "Tim", "Henry"]
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
