import SwiftUI
import Models
import EventKit

public struct EventDetailView : View, ViewModelInitializable {
	public var event: Event
	
	public init(_ event: Event) {
		self.event = event
	}
	
	public var body: some View {
		List {
			Text(event.title)
				.font(.title)
				.lineLimit(nil)
			Field(header: "When", text: event.summary)
			if event.venue?.address != nil {
				Field(header: "Where", text: event.venue!.addressDisplay)
				MapView(address: event.venue!.address.shortDisplay)
					.frame(height: 240)
					.cornerRadius(8)
			}
		}
		.navigationBarItems(trailing:
			Button(action: {
				let calendarManager = CalendarManager()
				if CalendarManager().calendarEvent(for: self.event) == nil {
					calendarManager.addEvent(self.event) { error in
						print(error as Any)
					}
				} else {
					calendarManager.removeEvent(self.event) { error in
						print(error as Any)
					}
				}
			}, label: {
				if CalendarManager().calendarEvent(for: self.event) == nil {
					Image(systemSymbol: .calendarBadgePlus)
				} else {
					Image(systemSymbol: .calendarBadgeMinus)
				}
			})
			//			LabelView(html: event.eventHTML ?? "")
			//			Text(event.eventHTML ?? "")
			//				.font(.body)
			//				.lineLimit(nil)
		)}
}

