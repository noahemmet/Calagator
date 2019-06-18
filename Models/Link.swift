import Foundation

public struct Link: Codable, Hashable {
	public var name: String?
	public var url: URL

	public init(name: String?, url: URL) {
		self.name = name ?? url.absoluteString
		self.url = url
	}
}
