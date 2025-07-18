//
//  CalendarService.swift
//  Learning
//
//  Created by Mehdi Shakibapour on 7/17/25.
//
import EventKit
import Foundation
import Observation

@Observable
final class CalendarService{
    
    // MARK: Variables and Dependencies
    
    private(set) var isAuthorized: Bool = false
    private(set) var errorMessage: String? = nil

    init() {
        checkAuthorizationStatus()
    }

    // MARK: Functions
    public func checkAuthorizationStatus() {
        
        switch EKEventStore.authorizationStatus(for: .event)
        {
        case .authorized, .fullAccess, .writeOnly:
            self.isAuthorized = true
            self.errorMessage = nil
        case .notDetermined:
            self.isAuthorized = false
            self.errorMessage = nil
        case .denied, .restricted:
            self.isAuthorized = false
            self.errorMessage = "Calendar access was denied. Please enable it in System Settings > Privacy & Security."
            
        @unknown default:
            self.isAuthorized = false
            self.errorMessage = "An unknown calendar permission status was encountered."
        }
    }
    
    public func requestWriteAcessToCalendar() async {
        do {
            let granted = try await EKEventStore().requestWriteOnlyAccessToEvents()
            self.isAuthorized = granted
            self.errorMessage = granted ? nil : "Calendar access was denied. Please enable it in System Settings > Privacy & Security."
        } catch {
            self.isAuthorized = false
            self.errorMessage = "Request Failed with error: \(error.localizedDescription)"
        }
    }
}
