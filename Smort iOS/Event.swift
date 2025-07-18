//
//  CalendarManager.swift
//  Learning
//
//  Created by Mehdi Shakibapour on 7/16/25.
//

import FoundationModels
import Foundation

@Generable
struct Event {
    @Guide(description: "A summary or title of the Event")
    var title: String

    @Guide(description: "A relevant URL for this event, if any")
    var url: String?

    @Guide(description: "Must-knows or notes about the event")
    var notes: String?

    @Guide(description: "Time(s) and day(s) of the event")
    var time: String

    @Guide(description: "Where the event is exactly")
    var location: String?

    @Guide(description: "Does the event repeat?")
    var hasRecurrenceRules: Bool

    @Guide(description: "Is this an all-day event?")
    var isAllDay: Bool
}
