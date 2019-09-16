import UIKit
import SwiftUI
import SwiftRichString
import Common

public struct LabelView: UIViewRepresentable {
	public let attributedText: NSAttributedString
	
  public init(html: String, fallback: String) {
    self.attributedText = (try? .init(html: html)) ?? .init(string: fallback)
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
