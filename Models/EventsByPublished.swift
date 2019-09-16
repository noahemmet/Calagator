import Common
import SwiftUI
import Combine

/// Stores an array of events, sorted by published date.
public struct EventsByPublished: SortedEvents, Codable, Hashable, Identifiable {
	static let dateFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateStyle = .long
		df.doesRelativeDateFormatting = true
		return df
	}()
	public var id: Date { date }
	public var dateComponents: DateComponents
	public var events: [Event]
	public var date: Date
	public var dateString: String {
		let day = EventsByDay.dateFormatter.string(from: date)
		return day
	}
	
	public static func from(events: [Event]) -> [EventsByPublished] {
		let eventsWithPublishedDates = events.filter { $0.published != nil }
		let eventsByDateComponents = Dictionary(grouping: eventsWithPublishedDates) { (event) -> DateComponents in
			let date = Calendar.current.dateComponents([.calendar, .day, .year, .month], from: (event.published!))
			return date
		}
		let eventsByDay: [EventsByPublished] = eventsByDateComponents.map { .init(dateComponents: $0, events: $1) }
		let sorted = eventsByDay.sorted(by: { $0.date > $1.date })
		return sorted
	}
	
	public init(dateComponents: DateComponents, events: [Event]) {
		self.dateComponents = dateComponents
		self.date = dateComponents.date!
		self.events = events
	}
}
