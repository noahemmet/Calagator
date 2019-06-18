import Foundation

public struct Address: Codable, Hashable {
	public var street: String
	public var locality: String
	public var region: String
	public var postalCode: String
	public var country: String
	public var googleMapsURL: URL
}
