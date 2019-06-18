import SwiftUI
import Models

public struct EventsView : View {
	public var events: [Event]
	
	public var body: some View {
		NavigationView {
			List(events.identified(by: \.id)) { event in
				NavigationButton(destination: EventDetailView(event: event), isDetail: true) {
					EventRow(event: event)
				}
				}
				.navigationBarTitle(Text("Events"))
		}
	}
}

#if DEBUG
struct EventsView_Previews : PreviewProvider {
	static var previews: some View {
		EventsView(events: [])
	}
}
#endif
