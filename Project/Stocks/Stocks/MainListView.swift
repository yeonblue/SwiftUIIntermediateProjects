//
//  ContentView.swift
//  Stocks
//
//  Created by yeonBlue on 2023/01/21.
//

import SwiftUI

struct MainListView: View {
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

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
