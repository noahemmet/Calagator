import SwiftUI

public struct Field: View {
	public let header: String
	public let text: String

	public init(header: String, text: String?) {
		guard let text = text else {
			self.header = ""
			self.text = ""
			return
		}
		self.header = header
		self.text = text
	}
	
	public var body: some View {
		VStack(alignment: .leading, spacing: 2) {
			Text(header)
				.font(.footnote)
				.foregroundColor(.secondary)
			Text(text)
				.font(.body)
				.foregroundColor(.primary)
				.lineLimit(Int.max) // nil wasn't wrapping correctly
		}
	}
}
