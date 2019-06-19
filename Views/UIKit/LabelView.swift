import UIKit
import SwiftUI

public struct LabelView: UIViewRepresentable {
	public let attributedText: NSAttributedString
	
	public init(attributedText: NSAttributedString) {
		self.attributedText = attributedText
	}
	
	public init(html: String) throws {
		let data = Data(html.utf8)
		self.attributedText = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
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
