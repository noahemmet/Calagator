import SwiftUI
import FeedKit

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
	
	public init?(atomEntry: AtomFeedEntry) {
		guard
			let idString = atomEntry.id,
			let idSlashIndex = idString.firstIndex(of: "/"),
			let title = atomEntry.title,
			let summary = atomEntry.summary?.value
		else {
			return nil
		}
		let idIndex = idString.index(after: idSlashIndex)
		let id = Int(idString.suffix(from: idIndex))
		let links: [Link] = atomEntry.links?.compactMap { Link(atomLink: $0) } ?? []
		self.init(id: id!, title: title, summary: summary, eventDescription: nil, links: links, venue: nil, venueDetails: nil, start: .init(), end: .init(), tags: [])
	}
}
