import SwiftUI
import FeedKit
import SwiftSoup
import Common

public struct Event: Codable, Hashable, Identifiable {
	static let atomDF: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
		return df
	}()
	
	static let timeDF: DateFormatter = {
		let df = DateFormatter()
		df.timeStyle = .short
		df.locale = Locale.current
		return df
	}()
	
	static let dayDF: DateFormatter = {
		let df = DateFormatter()
		df.dateStyle = .long
		df.doesRelativeDateFormatting = true
		df.locale = Locale.current
		return df
	}()
	
	public var id: Int
	public var title: String
	public var summary: String
	public var eventDescription: String?
	public var eventHTML: String?
	/// The URL to open in Calagator.org
	public var pageURL: URL
	public var links: [Link]
	public var venue: Venue?
	public var venueDetails: String?
	public var start: Date
	public var startTime: String {
		return Event.timeDF.string(from: start)
	}
	public var end: Date?
	public var endTime: String {
		guard let end = end else { return "" }
		return Event.timeDF.string(from: end)
	}
	
	public var totalTime: String {
		let endTime = self.endTime
		return startTime + (endTime.isEmpty ? "" : " — " + endTime)		
	}
	
	public var dateTimeDisplay: String {
		let dateDisplay = Event.dayDF.string(from: start)
		return dateDisplay + "\n" + totalTime		
	}
	
	public var tags: [Tag]

	public init(id: Int, title: String, summary: String, eventDescription: String? = nil, eventHTML: String? = nil, links: [Link] = [], venue: Venue? = nil, venueDetails: String? = nil, start: Date, end: Date?, tags: [Tag] = []) {
		self.id = id
		self.title = title
		self.summary = summary
		self.eventDescription = eventDescription
		self.eventHTML = eventHTML
		self.pageURL = URL(string: "http://calagator.org/events/\(id)")!
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
		
//		let links: [Link] = atomEntry.links?.compactMap { Link(atomLink: $0) } ?? []
		
		let venue: Venue?
		if let location = try? doc.select("div.location").first {
			venue = try? Venue(htmlElement: location)
		} else {
			venue = nil
		}
		
		/* Example dates:
			<time class="dtstart dt-start" title="2019-06-17T17:30:00" datetime="2019-06-17T17:30:00">Monday, June 17, 2019 from 5:30</time>–
			<time class="dtend dt-end" title="2019-06-17T20:30:00" datetime="2019-06-17T20:30:00">8:30pm</time>
		*/
		
		let startString = try doc.select("time")
			.element(at: 0)
			.unwrap(orThrow: "No start date found")
			.attr("datetime")
		let start = try Event.atomDF.date(from: startString)
			.unwrap(orThrow: "Couldn't resolve start date from \(startString)")
		let end: Date?
		if let endString = try doc.select("time")
			.element(at: 1)?
			.attr("datetime") {
			end = try Event.atomDF.date(from: endString).unwrap(orThrow: "Couldn't resolve end date from \(endString)")
		} else {
			end = nil
		}
		
		let description = try doc.select("div.description")
		let eventDescription = try description.text()
		
		let descriptionLinkDocs = try description.select("a")
		let descriptionLinks = try descriptionLinkDocs.array().compactMap { Link(urlString: try $0.text()) }
		
		// TODO: Get website link
		let links = descriptionLinks
		
		// This crashes on an empty string.
		let eventHTML = description.isEmpty() ? nil : try description.html()

		self.init(id: id, title: title, summary: summary, eventDescription: eventDescription, eventHTML: eventHTML, links: links, venue: venue, venueDetails: nil, start: start, end: end, tags: [])
	}
}
