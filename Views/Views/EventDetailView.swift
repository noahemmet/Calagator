import SwiftUI
import Models

public struct EventDetailView : View {
	public var event: Event
	
	public var body: some View {
		NavigationView {
			VStack(alignment: .leading, spacing: 8) {
				Text(event.title)
				Text(event.summary)
//				Text(event.eventDescription ?? "")
				Button(action: {
					print("Add to calendar")
					return
				}, label: {
					Text("Add to Calendar")
				})
			}
		}
			.navigationBarTitle(Text("Event"))
	}
}

