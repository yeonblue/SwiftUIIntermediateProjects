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
                Text("AnimatingCircles")
            }

            NavigationLink {
                RecordPlayer()
            } label: {
                Text("RecordPlayer")
            }
            
            NavigationLink {
                HueRotation()
            } label: {
                Text("HueRotation")
            }
            
            NavigationLink {
                BreathingFlower()
            } label: {
                Text("BreathingFlower")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
