import Foundation
import SwiftSoup

public struct Address: Codable, Hashable {
	public var street: String
	public var locality: String
	public var region: String
	public var postalCode: String
	public var country: String
	public var googleMapsURL: URL?

	public init(street: String, locality: String, region: String, postalCode: String, country: String, googleMapsURL: URL?) {
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
		let locality = try addressElement.select("div.locality").text()
		let region = try addressElement.select("div.region").text()
		let postalCode = try addressElement.select("div.postal-code").text()
		let country = try addressElement.select("div.country-name").text()
		let googleMapsURL: URL?
		if let googleMapsString = try addressElement.select("a[href*=maps.google]").first()?.attr("href") {
			googleMapsURL = URL(string: googleMapsString)
		} else {
			googleMapsURL = nil
		}
		self.init(street: street, locality: locality, region: region, postalCode: postalCode, country: country, googleMapsURL: googleMapsURL)
	}
}
