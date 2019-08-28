import Foundation
import FeedKit

public struct Link: Codable, Hashable, Identifiable {
	public var id: URL { url }
	public var name: String
	public var url: URL

	public init(name: String? = nil, url: URL) {
		self.name = name ?? url.absoluteString
		self.url = url
	}
	
	public init?(name: String? = nil, urlString: String) {
		self.name = name ?? urlString
		guard let url = URL(string: urlString) else { return nil }
		self.url = url
	}
	
	public init?(atomLink: AtomFeedEntryLink) {
		guard let href = atomLink.attributes?.href,
			let url = URL(string: href),
			Link.excludeLink(href) == false
			else {
			return nil
		}
		let name = atomLink.attributes?.title
		self.init(name: name, url: url)
	}
	
	/// Excludes .ics links and page links, because we'll represent those with custom UI.
	private static func excludeLink(_ href: String) -> Bool {
		return false
		let exclude =
			href.hasSuffix(".ics") ||
			href.hasPrefix("http://calagator.org/events/")
		if !exclude {
			print(href)
		}
		return exclude
	}
}
