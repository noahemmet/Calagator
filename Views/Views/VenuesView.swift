//
//  VenuesView.swift
//  Views
//
//  Created by Noah Emmet on 6/17/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import SwiftUI
import Models

/// Displays a list of all venues.
public struct VenuesView : View {
	public var venues: [Venue]
	public var body: some View {
		List {
			ForEach(venues) { venue in
				NavigationLink(destination: VenueDetailView(venue: venue)) {
					VenueRow(venue: venue)
				}
			}
		}
		.listStyle(GroupedListStyle())
	}
}

#if DEBUG
struct VenuesView_Previews : PreviewProvider {
	static var previews: some View {
		NavigationView {
			VenuesView(venues: [
				.init(id: 0, name: "Venue", description: "Venue Description", address: .debug)
			])
		}
	}
}
#endif
