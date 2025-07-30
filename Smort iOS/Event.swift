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
    @Guide(description: "A short title or summary of the event.")
    var title: String

    @Guide(description: "An optional link with more information about the event, such as a course page or Zoom link.")
    var url: String?

    @Guide(description: "Any notes or context for the event, such as professor name, section, or reminders.")
    var notes: String?

    @Guide(description: "When the event starts, expressed naturally. For example: 'next Tuesday at 8:30am', or 'August 29'.")
    var start: String

    @Guide(description: "When the event ends. Use natural language like '10:10am' or '2 hours later'. Leave nil if unknown.")
    var end: String?

    @Guide(description: "Where the event happens. For example: 'Schermerhorn Hall', 'Zoom', or an address.")
    var location: String?

    @Guide(description: "How often the event repeats. Use natural language like 'every Tuesday and Thursday', 'weekly', or leave nil if it doesn't repeat.")
    var recurrence: String?

    @Guide(description: "When the recurrence ends. Use natural language like 'until December 21' or leave nil for no end date.")
    var recurrenceEnd: String?

    @Guide(description: "True if the event takes the full day with no specific time. For example: 'true' for holidays. Use 'false' for timed events.")
    var isAllDay: String
}
