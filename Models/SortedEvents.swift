import Common
import SwiftUI
import Combine

/// Stores events, sorted by start and published dates.
public struct SortedEvents: Codable, Hashable {
	public let byDay: [EventsByDay]
	public let byPublished: [EventsByPublished]

	public init(events: [Event]) {
		self.byDay = EventsByDay.from(events: events)
		self.byPublished = EventsByPublished.from(events: events)
	}
	
	public init(byDay: [EventsByDay], byPublished: [EventsByPublished]) {
		self.byDay = byDay
		self.byPublished = byPublished
	}
	
	public func removingPastEvents(after date: Date = .init()) -> SortedEvents {
		let filteredByDay = byDay.filter { $0.date >= date }
		let filteredByPublished = byPublished.filter { $0.date >= date }
		return SortedEvents(byDay: filteredByDay, byPublished: filteredByPublished)
	}
}
