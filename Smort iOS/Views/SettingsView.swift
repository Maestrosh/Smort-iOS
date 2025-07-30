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
    @AppStorage("Custom Insutrctions") private var customInstructions: String = ""
    @State private var granted: Bool = false
    @State private var eventStore = EKEventStore()
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Intelligence Section
                Section(
                    header: Text("Custom Instructions"),
                    footer: Text("Provide instructions to guide the AI. Ex. Always add a 15-minute buffer before meetings.")
                ) {
                    TextField("",text: $customInstructions, axis: .vertical).lineLimit(4, reservesSpace: true)
                }
                
                // MARK: - General Section
                Section(header: Text("Status Check")) {
                    HStack {
                        switch model.availability {
                        case .available:
                            Text("On device AI model is available and ready to use")
                        case .unavailable(.deviceNotEligible):
                            Text("Device not eligible")
                        case .unavailable(.appleIntelligenceNotEnabled):
                            Text("Enable Apple Intelligence")
                        case .unavailable(.modelNotReady):
                            Text("Model is downloading...")
                        case .unavailable(_):
                            Text("Error")
                                .foregroundColor(.red)
                        }
                    }
                    HStack {
                        switch EKEventStore.authorizationStatus(for: .event) {
                        case .authorized, .fullAccess, .writeOnly:
                            Text("Calendar can't wait to save events")
                        case .notDetermined:
                            Button("Allow saving to calendar") {
                                Task {
                                    try await EKEventStore().requestWriteOnlyAccessToEvents()
                                }
                            }
                        case .denied, .restricted:
                            Button("Change calendar access level to Add Events Only") {
                                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(settingsURL)
                                }
                            }
                        @unknown default:
                            Text("Unknown calendar status. Check settings")
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
    SettingsView(model: SystemLanguageModel.default)
}
