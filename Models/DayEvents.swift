import Common

public struct EventsByDay: Codable, Hashable {
	public var dateComponents: DateComponents
	public var events: [Event]
	
	public static func from(events: [Event]) -> [EventsByDay] {
		let eventsByDateComponents = Dictionary(grouping: events) { (event) -> DateComponents in
			let date = Calendar.current.dateComponents([.day, .year, .month], from: (event.start))
			return date
		}
		let eventsByDay: [EventsByDay] = eventsByDateComponents.map { .init(dateComponents: $0, events: $1) }
		return eventsByDay
	}

	public init(dateComponents: DateComponents, events: [Event]) {
		self.dateComponents = dateComponents
		self.events = events
	}
}
