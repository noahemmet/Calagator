import SwiftUI
import Models

public struct EventsView : View {
	public var allEventsByDay: [EventsByDay]
	
	public var body: some View {
		NavigationView {
			List {
				ForEach(allEventsByDay) { eventsByDay in
					Section(header: Text(eventsByDay.dateString)) {
						ForEach(eventsByDay.events) { event in
							NavigationButton(destination: EventDetailView(event: event), isDetail: true) {
								EventRow(event: event)
							}
						}
					}
				}
				}
				.listStyle(.grouped)
				.navigationBarTitle(Text("Events"))
		}
	}
}

//#if DEBUG
//struct EventsView_Previews : PreviewProvider {
//	static var previews: some View {
//		EventsView(events: [])
//	}
//}
//#endif
