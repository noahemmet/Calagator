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
	@State private var showInSafari = false
	
	public var body: some View {
		List {
			Text(venue.name)
				.font(.title)
				.lineLimit(nil)
			if venue.address != nil {
				Field(header: "Where", text: venue.addressDisplay)
				MapView(address: venue.address!.shortDisplay)
					.frame(height: 240)
					.cornerRadius(8)
			}
		}
		.navigationBarItems(trailing:
			HStack(spacing: 16) {
				// Open in Safari
				Button(action: {
					self.showInSafari = true
				}, label: {
					Image(systemSymbol: .safari)
				})
			}
		)
			.sheet(isPresented: $showInSafari,
						 content: {
							SafariView(url: self.venue.pageURL)
			})

	}
}

struct VenueDetailView_Previews: PreviewProvider {
	static var previews: some View {
		VenueDetailView(venue: Venue(id: 0, name: "Venue Name", address: .debug))
	}
}
