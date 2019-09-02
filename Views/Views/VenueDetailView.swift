import SwiftUI
import Models

public struct VenueDetailView: View {
	public let venue: Venue
	@State private var showInSafari: Link?
	
	public var body: some View {
		List {
			Text(venue.name)
				.font(.title)
				.lineLimit(nil)
			if venue.address != nil {
				Field(header: "Address", text: venue.address?.shortDisplay)
				MapView(address: venue.address?.shortDisplay)
					.frame(height: 240)
					.cornerRadius(8)
			}
		}
		.navigationBarItems(trailing:
			HStack(spacing: 16) {
				// Open in Safari
				Button(action: {
					self.showInSafari = Link(url: self.venue.pageURL)
				}, label: {
					Image(systemSymbol: .safari)
				})
			}
		)
			.sheet(item: $showInSafari,
						 content: { link in
							SafariView(url: link.url)
			})

	}
}

struct VenueDetailView_Previews: PreviewProvider {
	static var previews: some View {
		VenueDetailView(venue: Venue(id: 0, name: "Venue Name", address: .debug))
	}
}
