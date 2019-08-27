import SwiftUI
import Models

public struct EventRow : View {
	
	public var event: Event
	
	public var body: some View {
		HStack(alignment: .firstTextBaseline, spacing: 8) {
			VStack(alignment: .trailing, spacing: 1) {
				// Start time
				Text(event.startTime)
					.font(.footnote)
					.foregroundColor(.primary)
				// End time
				Text(event.endTime)
					.font(.footnote)
					.foregroundColor(.secondary)
			}
				.frame(minWidth: 60) // prevents the dates from pushing the title text
//			Divider()
			VStack(alignment: .leading) {
				// Title
				Text(event.title)
					.font(.body)
					.foregroundColor(.primary)
				// Summary
				Text(event.venue?.name ?? event.summary)
					.font(.footnote)
					.foregroundColor(.secondary)
			}
		}
	}
}
