import SwiftUI

public struct Field<Content>: View where Content: View {
	public let header: String
	public let content: () -> Content
	
	public init(header: String, @ViewBuilder content: @escaping () -> Content) {
		self.header = header
		self.content = content
	}
	
	public var body: some View {
		VStack(alignment: .leading, spacing: 2) {
			Text(header)
				.font(.footnote)
				.foregroundColor(.secondary)
			content()
		}
	}
}

// TODO: I think there's a way to do this while constrained to a ViewModifier
extension Field where Content == AnyView {
	
	public init(header: String, text: String?) {
		guard let text = text else {
			self.header = ""
			self.content = { AnyView(Text("")) }
			return
		}
		self.header = header
		self.content = {
			AnyView(
				Text(text)
					.font(.body)
					.foregroundColor(.primary)
					.lineLimit(Int.max) // nil wasn't wrapping correctly
			)
		}
	}
}
