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
    @Guide(description: "A short title or summary of the event")
    var title: String

    @Guide(description: "An optional link with more information about the event")
    var url: String?

    @Guide(description: "Important details, notes, or context about the event")
    var notes: String?

    @Guide(description: "When the event starts, expressed naturally by the user (e.g. 'next Wednesday at 5pm')")
    var start: String

    @Guide(description: "When the event ends. If unknown, respond with 'not specified'")
    var end: String

    @Guide(description: "Exact location or address of the event")
    var location: String

    @Guide(description: "True if the event repeats over time (e.g. weekly, monthly)")
    var hasRecurrenceRules: Bool

    @Guide(description: "True if the event lasts all day, with no specific start or end time")
    var isAllDay: Bool
}

