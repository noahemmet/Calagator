import SwiftUI
import Models

struct VenuesLoadingView : View {
	@ObservedObject var venueFetcher = VenueFetcher()
	
	@State private var showAddVenue = false
	
	private var stateContent: AnyView {
		switch venueFetcher.state {
		case .loading:
			return AnyView(
				Text("Loading…")
					.foregroundColor(.secondary)
			)
		case .success(let venues):
			return AnyView(
				VenuesView(venues: venues)
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
			.sheet(isPresented: $showAddVenue,
						 content: {
							SafariView(url: URL(string: "http://calagator.org/venues/new")!)
			})
			.navigationBarTitle(Text("Venues"), displayMode: .inline)
			.navigationBarItems(trailing:
				Button(action: { self.showAddVenue = true }) {
					Image(systemSymbol: .plus)
			})
	}
}
