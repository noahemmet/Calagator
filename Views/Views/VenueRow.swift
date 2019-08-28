import SwiftUI
import Models

public struct VenueRow : View {
	
	public var venue: Venue
	
	public var body: some View {
		VStack(alignment: .leading) {
			Text(venue.name)
			Text(venue.addressDisplay)
				.foregroundColor(.secondary)
				.font(.footnote)
				.lineLimit(Int.max)
		}
	}
}
