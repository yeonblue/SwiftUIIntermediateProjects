//
//  MapAppApp.swift
//  MapApp
//
//  Created by yeonBlue on 2023/02/06.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
