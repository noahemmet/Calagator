import SwiftUI
import Models

public struct EventDetailView : View {
	public var event: Event
	
	public var body: some View {
		List {
			Text(event.title)
				.font(.title)
				.lineLimit(nil)
			Text(event.summary)
				.font(.body)
				.lineLimit(nil)
			MapView()
				.frame(height: 240)
				.cornerRadius(8)
			Text(event.venue?.address.shortDisplay ?? "")
				.font(.body)
				.lineLimit(3)
			//			.relativeWidth(1.0)
			//			.relativeHeight(2.0)
			Button(action: {
				print("Add to calendar")
				return
			}, label: {
				Text("Add to Calendar")
					.font(.body)
			})
				.accentColor(nil)
			Text(event.eventHTML ?? "")
				.font(.body)
				.lineLimit(nil)
		}
	}
}

