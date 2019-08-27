import SwiftUI
import Models

struct EventLoadingView : View {
	@ObservedObject var eventFetcher = EventFetcher()
	
	private var stateContent: AnyView {
		switch eventFetcher.state {
		case .loading:
			return AnyView(
				Text("Loading…")
			)
		case .success(let eventsByDay):
			return AnyView(
				EventsView(allEventsByDay: eventsByDay)
			)
		case .failure(let error):
			return AnyView(
				Text(error)
			)
		}
	}
	
	var body: some View {
		stateContent
			.transition(.opacity)
	}
}
