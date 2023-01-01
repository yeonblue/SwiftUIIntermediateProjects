//
//  CoreDataPracticeApp.swift
//  CoreDataPractice
//
//  Created by yeonBlue on 2022/12/31.
//

import SwiftUI

@main
struct CoreDataPracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
