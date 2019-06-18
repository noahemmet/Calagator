import SwiftUI
import Models

public struct EventsView : View {
	public var allEventsByDay: [EventsByDay]
	
	public var body: some View {
		NavigationView {
			List {
				ForEach(allEventsByDay) { eventsByDay in
					Section(header: Text(eventsByDay.dateString).font(.headline)) {
						ForEach(eventsByDay.events) { event in
							NavigationButton(destination: EventDetailView(event: event), isDetail: true) {
								EventRow(event: event)
							}
						}
					}
				}
				}
				.listStyle(.grouped)
				.navigationBarTitle(Text("Calagator"))
				.navigationBarItems(trailing:
					PresentationButton(destination: SafariView(url: URL(string: "http://calagator.org/events/new")!)) {
						Text("+")
					})
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
