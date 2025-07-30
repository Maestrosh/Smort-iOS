//
//  ContentView.swift
//  Learning
//
//  Created by Mehdi Shakibapour on 7/15/25.
//

import SwiftUI
import SwiftData
import Foundation
import FoundationModels
import EventKit

struct ContentView: View {
    let model = SystemLanguageModel.default
    let session = LanguageModelSession(instructions: "You are a Calendar assistant that extracts events from user's texts and organizes them into a calendar.")
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house"){
                HomeView(session: session)
            }
            Tab("Settings", systemImage: "gearshape"){
                SettingsView(model: model)
            }
            
        }.tabViewStyle(.automatic)
    }
}
#Preview {
    ContentView()
    .modelContainer(for: Item.self, inMemory: true)}
