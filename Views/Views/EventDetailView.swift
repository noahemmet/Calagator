import SwiftUI
import Models

public struct EventDetailView : View {
	public var event: Event
	
	public var body: some View {
		NavigationView {
			VStack {
				Text(event.title)
				Text(event.summary)
			}
			}
			.navigationBarTitle(Text("Event"))
	}
}

