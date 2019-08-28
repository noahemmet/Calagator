import SwiftUI
import SFSafeSymbols
import Models
import Common

public struct MainTabbedView : View {
	public enum Tab: Int {
		case events
		case venue
	}
	
	public init() { }
	
	@State private var selection = 0
	@State private var selectedEvent: Event?
	let eventLoadingView = EventLoadingView()
	
	public var body: some View {
		TabView(selection: $selection){
			// Events
			NavigationView {
				eventLoadingView
					.onAppear {
						self.eventLoadingView.eventFetcher.fetch()
				}
				EmptyView()
			}
			.tabItem {
				Image(systemSymbol: .calendar)
				Text("Events")
			}
			.tag(Tab.events)
			
			
			// Venues
			NavigationView {
				VenuesView()
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
		MainTabbedView()
	}
}
#endif
