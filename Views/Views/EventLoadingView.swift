import SwiftUI
import Models

struct EventLoadingView : View {
	@ObjectBinding var eventFetcher = EventFetcher()
	
	private var stateContent: AnyView {
		switch eventFetcher.state {
		case .loading:
			return AnyView(
				Text("Loading…")
			)
		case .success(let events):
			return AnyView(
				EventsView(events: events)
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
