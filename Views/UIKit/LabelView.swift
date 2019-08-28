import UIKit
import SwiftUI
import SwiftRichString
import Common

public struct LabelView: UIViewRepresentable {
	public let attributedText: NSAttributedString
	
	public init(html: String) {
		self.attributedText = .init()// (try? NSAttributedString(html: html)) ?? .init(string: "Loading error")
	}
	
	public init(html: String, baseFont: UIFont = UIFont.preferredFont(forTextStyle: .body), color: SwiftUI.Color = .primary) throws {
		let style = Style {
			$0.font = baseFont
//			$0.color = color
			$0.alignment = .left
		}
		attributedText = html.set(style: style)
	}
	
	public func makeUIView(context: UIViewRepresentableContext<LabelView>) -> UILabel {
		return UILabel()
	}
	
	public func updateUIView(_ label: UILabel,
							 context: UIViewRepresentableContext<LabelView>) {
		label.numberOfLines = 0
		label.attributedText = attributedText
	}
}
