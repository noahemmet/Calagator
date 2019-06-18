import Common
import SwiftUI
import Combine

public struct EventsByDay: Codable, Hashable, Identifiable {
	static let dateFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateStyle = .long
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
	
	public static func from(events: [Event]) -> [EventsByDay] {
		let eventsByDateComponents = Dictionary(grouping: events) { (event) -> DateComponents in
			let date = Calendar.current.dateComponents([.calendar, .day, .year, .month], from: (event.start))
			return date
		}
		let eventsByDay: [EventsByDay] = eventsByDateComponents.map { .init(dateComponents: $0, events: $1) }
		let sorted = eventsByDay.sorted(by: { $0.date < $1.date })
		return sorted
	}

	public init(dateComponents: DateComponents, events: [Event]) {
		self.dateComponents = dateComponents
		self.date = dateComponents.date!
		self.events = events
	}
}
