//
//  Item.swift
//  Learning
//
//  Created by Mehdi Shakibapour on 7/15/25.
//
import Foundation
import SwiftData

@Model
final class Item: Identifiable {
    var id: UUID
    var timestamp: Date
    var title: String
    var location: String?
    var startDate: Date
    var endDate: Date?
    var notes: String?
    var url: URL?
    var hasRecurrenceRules: Bool
    var isAllDay: Bool
    var calendarEventID: String?

    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        title: String,
        location: String? = nil,
        startDate: Date,
        endDate: Date? = nil,
        notes: String? = nil,
        url: URL? = nil,
        hasRecurrenceRules: Bool = false,
        isAllDay: Bool = false,
        calendarEventID: String? = nil
    ) {
        self.id = id
        self.timestamp = timestamp
        self.title = title
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
        self.url = url
        self.hasRecurrenceRules = hasRecurrenceRules
        self.isAllDay = isAllDay
        self.calendarEventID = calendarEventID
    }
}
