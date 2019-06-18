import SwiftUI
import MapKit

public struct MapView: UIViewRepresentable {
	
	public func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
		let mapView = MKMapView()
		return mapView
	}
	
	public func updateUIView(_ uiView: MKMapView,
									   context: UIViewRepresentableContext<MapView>) {
		// Nothing to do here.
	}
	
}
