import SwiftUI
import Models

public struct AddEventView : View {
	
	public var body: some View {
		NavigationView {
			Text("Add Event")
		}
			.navigationBarTitle(Text("Calagator"))
	}
}

//#if DEBUG
//struct EventsView_Previews : PreviewProvider {
//	static var previews: some View {
//		EventsView(events: [])
//	}
//}
//#endif
