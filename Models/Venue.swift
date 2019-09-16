import Foundation
import SwiftSoup
import Common

public typealias VenuesSortedAlphabetically = [String: [Venue]]

/// A location at which events are held.
public struct Venue: Hashable, Identifiable {
	public var id: Int
	public var name: String
	public var venueDescription: String?
	public var address: Address?
	/// The URL to open in Calagator.org
	public var pageURL: URL
	
	public var addressDisplay: String {
		
		if let shortDisplay = address?.shortDisplay {
			if shortDisplay.hasPrefix(name) {
				// If the venue name is part of the address, no need to display it twice
				return String(shortDisplay.dropFirst(name.count))
			} else {
				return name + "\n" + shortDisplay
			}
		} else {
			return name
		}
	}
	
	public var eventsByDay: [EventsByDay] = []

	public init(id: Int, name: String, description: String, address: Address) {
		self.id = id
		self.name = name
		self.address = address
		self.venueDescription = description
		self.pageURL = URL(string: "http://calagator.org/venues/\(id)")!
	}
	
	public init(htmlElement element: Element) throws {
		let location = try element.select("div.location").first.unwrap(orThrow: "No location found")
		let name = try location.select("span.fn").text()
		let address = try Address(htmlElement: location)
    let venueLink = try location.getElementsByClass("url").attr("href")
    let venueIDString = venueLink.replacingOccurrences(of: "/venues/", with: "")
    let venueID = try Int(venueIDString).unwrap()
		self.init(id: venueID, name: name, description: "", address: address)
	}
}

extension Venue: Codable {
	enum CodingKeys: String, CodingKey {
		case id
		case name = "title"
		case venueDescription = "description"
		
		case address
		case street = "street_address"
		case locality
		case region
		case postalCode = "postal_code"
		case country
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(Int.self, forKey: .id)
		self.pageURL = URL(string: "http://calagator.org/venues/\(id)")!
		self.name = try container.decode(String.self, forKey: .name)
		self.venueDescription = try container.decodeIfPresent(String.self, forKey: .venueDescription)
		
		do {
			self.address = try container.decode(Address.self, forKey: .address)
			
		} catch {
			// If address can't be decoded, it may be new json, which should be read directly.
			do {
				let street = try container.decode(String.self, forKey: .street)
				let locality = try container.decode(String.self, forKey: .locality)
				let region = try container.decodeIfPresent(String.self, forKey: .region) ?? ""
				let postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode) ?? ""
				let country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
				self.address = try Address(street: street, locality: locality, region: region, postalCode: postalCode, country: country, googleMapsURL: nil)
			} catch { }
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(venueDescription, forKey: .venueDescription)
		try container.encode(address, forKey: .address)
	}
}

extension Venue {
  public static let debug = Venue(id: 0, name: "Venue Name", description: "Venue Description", address: .debug)
}
