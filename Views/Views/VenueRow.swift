import SwiftUI
import Models

public struct VenueRow : View {
	
	public var venue: Venue
	
	public var body: some View {
		VStack() {
			Text(venue.name)
		}
	}
}
