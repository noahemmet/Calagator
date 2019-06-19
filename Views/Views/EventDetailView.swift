import SwiftUI
import Models
import EventKit

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
			if event.venue?.address != nil {
				MapView(address: event.venue!.address.shortDisplay)
					.frame(height: 240)
					.cornerRadius(8)
				Text(event.venue!.address.shortDisplay)
					.font(.body)
					.lineLimit(3)
			}
			//			.relativeWidth(1.0)
			//			.relativeHeight(2.0)
			Button(action: {
				let calendarManager = CalendarManager()
				if CalendarManager().calendarEvent(for: self.event) == nil {
					calendarManager.addEvent(self.event) { error in
						print(error)
					}
				} else {
					calendarManager.removeEvent(self.event) { error in
						print(error)
					}
				}
			}, label: {
				if CalendarManager().calendarEvent(for: self.event) == nil {
					Text("Add to Calendar")
						.font(.body)
						.color(.accentColor)
				} else {
					Text("Remove from Calendar")
						.font(.body)
						.color(.accentColor)
				}
			})
			Text(event.eventHTML ?? "")
				.font(.body)
				.lineLimit(nil)
		}
	}
}

