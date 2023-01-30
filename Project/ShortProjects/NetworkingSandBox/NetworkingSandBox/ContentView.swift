//
//  ContentView.swift
//  NetworkingSandBox
//
//  Created by yeonBlue on 2023/01/30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var headlines = [News]()
    @State private var messages = [Message]()
    
    @Environment(\.networkManager) var networkManager
    
    var body: some View {
        List {
            
            // Headline
            Section("Headlines") {
                ForEach(headlines) { headline in
                    VStack(alignment: .leading) {
                        Text(headline.title)
                            .font(.headline)
                        
                        Text(headline.strap)
                    }
                }
            }
            
            // Message
            Section("Messages") {
                ForEach(messages) { message in
                    VStack(alignment: .leading) {
                        Text(message.from)
                            .font(.headline)
                        
                        Text(message.text)
                    }
                }
            }
        }
        .task {
            do {
                headlines = try await networkManager.fetch(.headlines)
                messages = try await networkManager.fetch(.messages)
                print(try await networkManager.fetch(.inValidURL, defaultValue: []))
                print(try await networkManager.fetch(.inValidURL, attempts: 5))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
