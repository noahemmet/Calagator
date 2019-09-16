import Common
import SwiftUI
import Combine

/// Stores events, sorted by start and published dates.
public struct EventStore: Codable, Hashable {
  public enum SortMethod: Hashable {
    case byDay
    case byPublished
  }
  
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
  
  public func sortedEvents(for method: SortMethod) -> [SortedEvents] {
    switch method {
    case .byDay: return byDay
    case .byPublished: return byPublished
    }
  }
	
	public func removingPastEvents(after date: Date = .init()) -> EventStore {
		let filteredByDay = byDay.filter { $0.date >= date }
		let filteredByPublished = byPublished.filter { $0.date >= date }
		return EventStore(byDay: filteredByDay, byPublished: filteredByPublished)
	}
}
