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
						.isDetailLink(true)
					}
				}
			}
		}
		.listStyle(GroupedListStyle())
	}
}

//#if DEBUG
//struct EventsView_Previews : PreviewProvider {
//	static var previews: some View {
//		EventsView(events: [])
//	}
//}
//#endif
