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
    var id = UUID()
    var timestamp: Date
    var title: String
    var location: String?
    var startTime: String
    var endTime: String?
    var notes: String?
    var url: String?
    var hasRecurrenceRules: Bool
    var isAllDay: Bool
    init(timestamp: Date, title: String, starttime: String, endtime: String? = nil, location: String? = nil, notes: String? = nil, url: String? = nil, hasRecurrenceRules: Bool = false, isAllDay: Bool = false) {
        self.timestamp = timestamp
        self.title = title
        self.startTime = starttime
        self.endTime = endtime
        self.location = location
        self.notes = notes
        self.url = url
        self.hasRecurrenceRules = hasRecurrenceRules
        self.isAllDay = isAllDay
        
    }
    
}
