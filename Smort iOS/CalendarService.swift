////
////  CalendarService.swift
////  Learning
////
////  Created by Mehdi Shakibapour on 7/17/25.
////
//import EventKit
//import Foundation
//import Observation
//
//@Observable
//final class CalendarService{
//    
//    // MARK: Variables and Dependencies
//    
//    
//    public func extractDate(from string: String) -> Date? {
//        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue) else {return nil}
//        let range  = NSRange(string.startIndex..., in: string)
//        let matches = detector.matches(in: string, options: [], range: range)
//        return matches.first?.date
//
//    }
//    public func addEvent(from Event: Item) async throws -> String? {
//        let status = EKEventStore.authorizationStatus(for: .event)
//
//        guard  status == .fullAccess // iOS 17+ full read/write
//        || status == .writeOnly  // iOS 17+ add-events-only
//        else {
//            throw NSError(domain: "CalendarService", code: 401, userInfo: [NSLocalizedDescriptionKey: "Not authorized to access the calendar."])
//        }
//        
//        let newEvent = EKEvent(eventStore: EKEventStore())
//        newEvent.title = Event.title
//        guard case newEvent.startDate = extractDate(from: Event.startTime) else {print("we have a problem. start date is nil"); return nil}
//        newEvent.endDate = extractDate(from: Event.endTime ?? "" ) ?? Date(timeInterval: 3600, since: extractDate(from: Event.startTime)!)
//        newEvent.location = Event.location
//        newEvent.notes = Event.notes
//
//        do {
//            try EKEventStore().save(newEvent, span: .thisEvent, commit: true)
//            return newEvent.eventIdentifier
//        } catch {
//            print("Failed to save event: \(error)")
//            throw error
//        }
//    }
//}
