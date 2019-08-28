//
//  VenueDetailView.swift
//  Views
//
//  Created by Noah Emmet on 8/27/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import SwiftUI
import Models

public struct VenueDetailView: View {
	public let venue: Venue
	public var body: some View {
		Text(venue.name)
	}
}

struct VenueDetailView_Previews: PreviewProvider {
	static var previews: some View {
		VenueDetailView(venue: Venue(id: 0, name: "Venue Name", address: .debug))
	}
}
