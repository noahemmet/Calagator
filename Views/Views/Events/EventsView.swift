import SwiftUI
import Models

public struct EventsView : View {
	public var allEventsByDay: [EventsByDay]
	
	public var body: some View {
		List {
			ForEach(allEventsByDay) { eventsByDay in
				Section(header: Text(eventsByDay.dateString).font(.headline)) {
					ForEach(eventsByDay.events) { event in
						NavigationLink(destination: EventDetailView(event)) {
							EventRow(event: event)
						}
//						.isDetailLink(true)
					}
				}
			}
		}
		.listStyle(GroupedListStyle())
	}
}

struct EventsView_Previews : PreviewProvider {
	static let start = Date()
	static let end = start.addingTimeInterval(60*60)
	static let tomorrowStart = Date().addingTimeInterval(60*60*24)
	static let tomorrowEnd = tomorrowStart.addingTimeInterval(60*60)
	static var previews: some View {
		NavigationView {
			EventsView(allEventsByDay: EventsByDay.from(events: [
				.init(id: 0, title: "Event 1", summary: "Event Summary", start: start, end: end),
				.init(id: 1, title: "Event 2", summary: "Event Summary", start: tomorrowStart, end: tomorrowEnd),
			]))
		}
	}
}
