import SwiftUI
import Models
import EventKit
import MapKit

public struct EventDetailView : View {
	public var event: Event
	
	@State private var showInSafari: Link?
	@State private var showMapMenu: Bool = false
	
	public init(_ event: Event) {
		self.event = event
	}
	
	public var body: some View {
		List {
			Text(event.title)
				.font(.title)
				.lineLimit(nil)
			Field(header: "When", text: event.dateTimeDisplay, trailing: {
				Button(action: self.addOrRemoveCalendar) {
					if CalendarManager().calendarEvent(for: self.event) == nil {
						Image(systemSymbol: .calendarBadgePlus)
					} else {
						Image(systemSymbol: .calendarBadgeMinus)
					}
				}
			})
			if event.venue?.address != nil {
				Field(header: "Where", text: event.venue?.addressDisplay, trailing: {
					Button(action: { self.showMapMenu = true }) {
						Image(systemSymbol: .map)
					}
				})
				MapView(address: event.venue?.address?.shortDisplay)
					.frame(height: 240)
					.cornerRadius(8)
			}
			Field(header: "What", text: event.eventDescription)
			if self.event.links.isEmpty == false {
//				Field(header: "Links", content: {
//					ForEach(self.event.links) { link in
//						Button(action: { self.showInSafari = link } ) {
//							Text(link.name)
//						}
//					}
//				})
			}
		}
		.navigationBarItems(trailing:
			HStack(spacing: 16) {
//				Button(action: addOrRemoveCalendar) {
//					if CalendarManager().calendarEvent(for: self.event) == nil {
//						Image(systemSymbol: .calendarBadgePlus)
//					} else {
//						Image(systemSymbol: .calendarBadgeMinus)
//					}
//				}
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
			.actionSheet(isPresented: $showMapMenu) {
				ActionSheet(title: Text(event.venue?.addressDisplay ?? ""), message: nil, buttons: [
					.default(Text("Show in Maps"), action: { self.launchMaps(for: self.event.venue!.addressDisplay)}),
					.cancel(Text("Cancel"))
				])
		}
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
	
	private func launchMaps(for address: String) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(address) { 
			(placemarks, error) in
			guard error == nil, let placemark = placemarks?.first else {
				return
			}
			let item = MKMapItem(placemark: .init(placemark: placemark))
			item.openInMaps(launchOptions: nil)
		}
	}
}

struct EventDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EventDetailView(.debug)
    }
  }
}
