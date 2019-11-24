import SwiftUI
import SFSafeSymbols
import Models
import Common

/// Displays the Events and Venues tab
public struct MainTabView : View {
	public enum Tab: Int {
		case events
		case venue
	}
	
	public init() { }
	
	@State private var selection = Tab.events
//	@Environment(\.device) private var device: Device
	@EnvironmentObject var device: Device
	
	let eventsLoadingView = EventsLoadingView()
	let venuesLoadingView = VenuesLoadingView()
	
	public var body: some View {
		TabView(selection: $selection){
			// MARK: Events
			NavigationView {
				eventsLoadingView
					.onAppear {
						self.eventsLoadingView.eventFetcher.fetch(useCache: !isFastlaneSnapshot)
				}
				Text("Calagator Events")
					.font(.title)
					.bold()
					.foregroundColor(.secondary)
			}
			.padding(device.isLandscape ? 0 : 0.5) // Show iPad side bar in portrait and landscape
			.tag(Tab.events)
			.tabItem {
				Image(systemSymbol: .calendar)
				Text("Events")
			}
			
			// MARK: Venues
			NavigationView {
				venuesLoadingView
					.onAppear {
						self.venuesLoadingView.venueFetcher.fetch(useCache: !isFastlaneSnapshot)
				}
				Text("Local Venues")
					.font(.title)
					.bold()
					.foregroundColor(.secondary)
			}
			.padding(device.isLandscape ? 0 : 0.5) // Show iPad side bar in portrait and landscape
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
