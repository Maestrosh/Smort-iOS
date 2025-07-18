//
//  SettingsView.swift
//  Learning
//
//  Created by Mehdi Shakibapour on 7/17/25.
//

import SwiftUI
import FoundationModels
import EventKit

import Observation

struct SettingsView: View {
    
    let model: SystemLanguageModel
    @Bindable var calendarService: CalendarService
    @AppStorage("Custom Insutrctions") private var customInstructions: String = ""
    @State private var granted: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Intelligence Section
                Section(
                    header: Text("Custom Instructions"),
                    footer: Text("Provide instructions to guide the AI. Always add a 15-minute buffer before meetings.")
                ) {
                    TextField("",text: $customInstructions, axis: .vertical).lineLimit(4, reservesSpace: true)
                }
                
                // MARK: - General Section
                Section(header: Text("Status Check")) {
                    HStack {
                        switch model.availability {
                        case .available:
                            Text("Model is Available and Ready to Use")
                        case .unavailable(.deviceNotEligible):
                            Text("Device Not Eligible")
                        case .unavailable(.appleIntelligenceNotEnabled):
                            Text("Enable Apple Intelligence")
                        case .unavailable(.modelNotReady):
                            Text("Model is Downloading...")
                        case .unavailable(_):
                            Text("Error")
                                .foregroundColor(.red)
                        }
                    }
                    HStack {
                        switch calendarService.isAuthorized {
                        case true:
                            Text("Calendar Access Granted")
                        case false:
                            Text("Change Calendar Access Level to Write Only")
                        }
                    }
                }
                
                // MARK: - About Section
                Section(header: Text("About")) {
                    HStack {
                        Text("App Version")
                        Text(appVersion)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Link("Help & Feedback", destination: mailtoLink)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }.scrollDismissesKeyboard(.immediately)
    }
    // MARK: - Other
    
    private var appVersion: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
        return "\(version) (\(build))"
    }
    
    private var mailtoLink: URL! {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "App"
        let subject = "\(appName) Feedback (\(appVersion))".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "mailto:ms7251@columbia.edu?subject=\(subject)")
    }
}

#Preview {
    SettingsView(model: SystemLanguageModel.default, calendarService: CalendarService())
}
