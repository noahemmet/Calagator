import SwiftUI
import FeedKit
import SwiftSoup
import Common

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

// MARK: - Atom

extension Event {
	public init(atomEntry: AtomFeedEntry) throws {
		let idString = try atomEntry.id.unwrap()
		let idSlashIndex = try idString.firstIndex(of: "/").unwrap()
		let title = try atomEntry.title.unwrap()
		let summary = try atomEntry.summary.unwrap().value.unwrap()
		let contentHTML = try atomEntry.content.unwrap().value.unwrap()
		let doc = try SwiftSoup.parse(contentHTML)
		let idIndex = idString.index(after: idSlashIndex)
		let id = Int(idString.suffix(from: idIndex))!
		let links: [Link] = atomEntry.links?.compactMap { Link(atomLink: $0) } ?? []
		
		let venue: Venue?
		if let location = try? doc.select("div.location").first {
			venue = try? Venue(htmlElement: location)
		} else {
			venue = nil
		}
		
		self.init(id: id, title: title, summary: summary, eventDescription: nil, links: links, venue: venue, venueDetails: nil, start: .init(), end: .init(), tags: [])
	}
}
