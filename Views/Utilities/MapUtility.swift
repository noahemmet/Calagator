import Foundation
import MapKit

public struct MapUtility {
  public static func launchMaps(for address: String) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(address) {
      (placemarks, error) in
      guard error == nil, let placemark = placemarks?.first else {
        return
      }
      let item = MKMapItem(placemark: .init(placemark: placemark))
      item.openInMaps(launchOptions: nil)
    }
  }
}
