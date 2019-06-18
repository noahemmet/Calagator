import Foundation

public struct Event: Codable, Hashable {
	public var title: String
	public var summary: String
	public var eventDescription: String?
	public var url: URL
	public var venue: Venue?
	public var venueDetails: String?
	public var start: Date
	public var end: Date
	public var tags: [Tag]
}
