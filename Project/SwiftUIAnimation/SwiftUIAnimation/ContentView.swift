//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by yeonBlue on 2023/02/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            NavigationLink {
                AnimatingCircles()
            } label: {
                Text("1. AnimatingCircles")
            }

            NavigationLink {
                RecordPlayer()
            } label: {
                Text("2. RecordPlayer")
            }
            
            NavigationLink {
                HueRotation()
            } label: {
                Text("3. HueRotation")
            }
            
            NavigationLink {
                BreathingFlower()
            } label: {
                Text("4. BreathingFlower")
            }
            
            NavigationLink {
                FlyingEagle()
            } label: {
                Text("5. FlyingEagle")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
