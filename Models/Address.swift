import Foundation
import SwiftSoup
import Common

extension Address {
	public static let debug = try! Address(street: "Main Street", locality: "Locality", region: "Region", postalCode: "90210", country: "US", googleMapsURL: nil)
}

public struct Address: Hashable {
	public var street: String
	public var locality: String
	public var region: String
	public var postalCode: String
	public var country: String
	public var googleMapsURL: URL?
	
	public var fullDisplay: String {
		shortDisplay + " " + country
	}
	
	public var shortDisplay: String {
		street + "\n" + locality + ", " + region + " " + postalCode
	}

	public init(street: String, locality: String, region: String, postalCode: String, country: String, googleMapsURL: URL?) throws {
		guard !street.isEmpty, !locality.isEmpty else {
			throw BasicError.reason("empty address")
		}
		self.street = street
		self.locality = locality
		self.region = region
		self.postalCode = postalCode
		self.country = country
		self.googleMapsURL = googleMapsURL
	}
	
	public init(htmlElement element: Element) throws {
		let addressElement = try element.select("div.adr")
		
		/* Example HTML:
		  <div class="street-address">
		  111 SW 5th Ave #2700
		  </div>
		  <span class="locality">Portland</span> ,
		  <span class="region">OR</span>
		  <span class="postal-code">97204</span>
		  <div class="country-name">
		  us
		  <div>
		  (
		  <a href="https://maps.google.com/maps?q=111%20SW%205th%20Ave%20%232700,%20Portland%20OR%2097204%20us">map</a>)
		  </div>
		  </div>
		*/
		
		let street = try addressElement.select("div.street-address").text()
		let locality = try addressElement.select("span.locality").text()
		let region = try addressElement.select("span.region").text()
		let postalCode = try addressElement.select("span.postal-code").text()
		let country = try addressElement.select("div.country-name").text()
		let googleMapsURL: URL?
		if let googleMapsString = try addressElement.select("a[href*=maps.google]").first()?.attr("href") {
			googleMapsURL = URL(string: googleMapsString)
		} else {
			googleMapsURL = nil
		}
		try self.init(street: street, locality: locality, region: region, postalCode: postalCode, country: country, googleMapsURL: googleMapsURL)
	}
}

extension Address: Codable {
	enum CodingKeys: String, CodingKey {
		case street = "street_address"
		case locality
		case region
		case postalCode = "postal_code"
		case country
	}
}
