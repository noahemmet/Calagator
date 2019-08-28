import SwiftUI
import Models
import EventKit

public struct EventDetailView : View {
	public var event: Event
	
	@State private var showInSafari: Link?
	
	public init(_ event: Event) {
		self.event = event
	}
	
	public var body: some View {
		List {
			Text(event.title)
				.font(.title)
				.lineLimit(nil)
			Field(header: "When", text: event.totalTime)
			if event.venue?.address != nil {
				Field(header: "Where", text: event.venue?.addressDisplay)
				MapView(address: event.venue!.address!.shortDisplay)
					.frame(height: 240)
					.cornerRadius(8)
			}
			Field(header: "What", text: event.eventDescription)
			if self.event.links.isEmpty == false {
				Field(header: "Links", content: {
					ForEach(self.event.links) { link in
						Button(action: { self.showInSafari = link } ) {
							Text(link.name)
						}
					}
				})
			}
		}
		.navigationBarItems(trailing:
			HStack(spacing: 16) {
				Button(action: addOrRemoveCalendar) {
					if CalendarManager().calendarEvent(for: self.event) == nil {
						Image(systemSymbol: .calendarBadgePlus)
					} else {
						Image(systemSymbol: .calendarBadgeMinus)
					}
				}
				// Open in Safari
				Button(action: {
					self.showInSafari = Link(url: self.event.pageURL)
				}, label: {
					Image(systemSymbol: .safari)
				})
			}
			//			LabelView(html: event.eventHTML ?? "")
			//			Text(event.eventHTML ?? "")
			//				.font(.body)
			//				.lineLimit(nil)
		)
			.sheet(item: $showInSafari,
						 content: { link in
							SafariView(url: link.url)
			})
	}
	
	private func addOrRemoveCalendar() {
		// Add/Remove from calendar
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

	}
	
}

