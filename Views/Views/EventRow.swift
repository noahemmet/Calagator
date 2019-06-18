import SwiftUI
import Models

public struct EventRow : View {
	
	public var event: Event
	
	public var body: some View {
		VStack(alignment: .leading) {
			Text(event.title)
				.font(.body)
			Text(event.summary)
				.font(.footnote)
				.color(.secondary)
		}
	}
}
