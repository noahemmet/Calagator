import SwiftUI

public struct Event: Codable, Hashable, Identifiable {
	public var id: Int
	public var title: String
	public var summary: String
	public var eventDescription: String?
	public var links: [Link]
	public var venue: Venue?
	public var venueDetails: String?
	public var start: Date
	public var end: Date
	public var tags: [Tag]

	public init(id: Int, title: String, summary: String, eventDescription: String? = nil, links: [Link] = [], venue: Venue? = nil, venueDetails: String? = nil, start: Date = .init(), end: Date = .init(), tags: [Tag] = []) {
		self.id = id
		self.title = title
		self.summary = summary
		self.eventDescription = eventDescription
		self.links = links
		self.venue = venue
		self.venueDetails = venueDetails
		self.start = start
		self.end = end
		self.tags = tags
	}
}
