import SwiftUI
import SFSafeSymbols
import Models
import Common

public struct MainTabView : View {
	public enum Tab: Int {
		case events
		case venue
	}
	
	public init() { }
	
	@State private var selection = Tab.venue
	let eventsLoadingView = EventsLoadingView()
	let venuesLoadingView = VenuesLoadingView()
	
	public var body: some View {
		TabView(selection: $selection){
			// MARK: Events
			NavigationView {
				eventsLoadingView
					.onAppear {
						self.eventsLoadingView.eventFetcher.fetch()
				}
				EmptyView()
			}
			.tag(Tab.events)
			.tabItem {
				Image(systemSymbol: .calendar)
				Text("Events")
			}
			
			// MARK: Venues
			NavigationView {
				venuesLoadingView
					.onAppear {
						self.venuesLoadingView.venueFetcher.fetch()
				}
				EmptyView()
			}
			.tag(Tab.venue)
			.tabItem {
				Image(systemSymbol: .map)
				Text("Venues")
			}
		}
	}
}

#if DEBUG
struct MainTabbedView_Previews : PreviewProvider {
	static var previews: some View {
		MainTabView()
	}
}
#endif
