import Foundation
import FeedKit

public struct Link: Codable, Hashable {
	public var name: String?
	public var url: URL

	public init(name: String?, url: URL) {
		self.name = name ?? url.absoluteString
		self.url = url
	}
	
	public init?(atomLink: AtomFeedEntryLink) {
		guard let href = atomLink.attributes?.href else {
			return nil
		}
		let url = URL(string: href)!
		let name = atomLink.attributes?.title
		self.init(name: name, url: url)
	}
}
