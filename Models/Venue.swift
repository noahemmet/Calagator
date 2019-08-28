import Foundation
import SwiftSoup
import Common

public struct Venue: Hashable, Identifiable {
	public var id: Int
	public var name: String
	public var address: Address?
	/// The URL to open in Calagator.org
	public var pageURL: URL
	
	public var addressDisplay: String {
		if let shortDisplay = address?.shortDisplay {
			return name + "\n" + shortDisplay
		} else {
			return name
		}
	}

	public init(id: Int, name: String, address: Address) {
		self.id = id
		self.name = name
		self.address = address
		self.pageURL = URL(string: "http://calagator.org/venues/\(id)")!
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

extension Venue: Decodable {
	enum CodingKeys: String, CodingKey {
		case id
		case name = "title"
		
		case street = "street_address"
		case locality
		case region
		case postalCode = "postal_code"
		case country
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.pageURL = URL(string: "http://calagator.org/events/\(id)")!
		self.name = try container.decode(String.self, forKey: .name)
		
		do {
			let street = try container.decode(String.self, forKey: .street)
			let locality = try container.decode(String.self, forKey: .locality)
			let region = try container.decode(String.self, forKey: .region)
			let postalCode = try container.decode(String.self, forKey: .postalCode)
			let country = try container.decode(String.self, forKey: .country)
			self.address = try Address(street: street, locality: locality, region: region, postalCode: postalCode, country: country, googleMapsURL: nil)
		} catch let error {
			print(error)
		}
	}
}
