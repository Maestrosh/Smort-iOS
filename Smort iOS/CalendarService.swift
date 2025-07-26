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
    public func extractDate(from string: String) -> Date? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue) else {return nil}
        let range  = NSRange(string.startIndex..., in: string)
        let matches = detector.matches(in: string, options: [], range: range)
        return matches.first?.date

    }
    public func addEvent(from Event: Item) async throws -> String? {
        guard isAuthorized else {
            throw NSError(domain: "CalendarService", code: 401, userInfo: [NSLocalizedDescriptionKey: "Not authorized to access the calendar."])
        }
        
        let newEvent = EKEvent(eventStore: EKEventStore())
        newEvent.title = Event.title
        guard case newEvent.startDate = extractDate(from: Event.startTime) else {print("we have a problem. start date is nil"); return nil}
        newEvent.endDate = extractDate(from: Event.endTime ?? "" ) ?? Date(timeInterval: 3600, since: extractDate(from: Event.startTime)!)
        newEvent.location = Event.location
        newEvent.notes = Event.notes

        do {
            try EKEventStore().save(newEvent, span: .thisEvent, commit: true)
            return newEvent.eventIdentifier
        } catch {
            print("Failed to save event: \(error)")
            throw error
        }
    }
}
