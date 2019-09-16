import SwiftUI
import Models

struct EventsLoadingView : View {
	@ObservedObject var eventFetcher = EventFetcher()
	
	@State private var showAddEvent = false
	
	private var stateContent: AnyView {
		switch eventFetcher.state {
		case .loading:
			return AnyView(
				Text("Loading…")
					.foregroundColor(.secondary)
			)
		case .success(let eventStore):
			return AnyView(
				EventsView(eventStore: eventStore)
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
			.sheet(isPresented: $showAddEvent,
						 content: {
							SafariView(url: URL(string: "http://calagator.org/events/new")!)
			})
			.navigationBarTitle(Text("Events"), displayMode: .inline)
			.navigationBarItems(trailing:
				Button(action: { self.showAddEvent = true }) {
					Image(systemSymbol: .plus)
			})
	}
}
