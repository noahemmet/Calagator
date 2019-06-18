import Foundation
import SwiftSoup
import Common

public struct Venue: Codable, Hashable {
	public var id: Int
	public var name: String
	public var address: Address

	public init(id: Int, name: String, address: Address) {
		self.id = id
		self.name = name
		self.address = address
	}
	
	public init(htmlElement element: Element) throws {
		let location = try element.select("div.location").first.unwrap(orThrow: "No location found")
		let name = try location.select("span.fn").text()
		let address = try Address(htmlElement: location)
		self.init(id: 0, name: name, address: address)
		// Element <div class="location vcard">
//		<a href="/venues/202396329" class="url"> <span class="fn org">New Relic</span> </a>

	}
}
