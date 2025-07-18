//
//  LearningApp.swift
//  Learning
//
//  Created by Mehdi Shakibapour on 7/15/25.
//

import SwiftUI
import SwiftData

@main
struct LearningApp: App {
    
    // Shared Model Container Crap
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    //Window Group containing ContentView with .modelContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
