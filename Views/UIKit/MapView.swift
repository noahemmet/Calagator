import SwiftUI
import MapKit
import CoreLocation

public struct MapView: UIViewRepresentable {
	public let address: String?
	
	public func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
		let mapView = MKMapView()
		return mapView
	}
	
	public func updateUIView(_ mapView: MKMapView,
							 context: UIViewRepresentableContext<MapView>) {
		guard let address = address, !address.isEmpty else {
			return
		}
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(address) { placemarks, error in
			if let placemark = placemarks?.first, let location = placemark.location {
				let mark = MKPlacemark(placemark: placemark)
				
				var region = mapView.region
				region.center = location.coordinate
				region.span.longitudeDelta = 0.02
				region.span.latitudeDelta = 0.02
				mapView.setRegion(region, animated: true)
				mapView.addAnnotation(mark)
				
			}
		}
	}
}
