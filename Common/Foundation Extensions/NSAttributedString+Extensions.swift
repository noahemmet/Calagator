import UIKit
import SwiftUI

public extension NSAttributedString {
	convenience init(html: String, font: UIFont = UIFont.preferredFont(forTextStyle: .body), color: SwiftUI.Color = .primary, linkColor: SwiftUI.Color = .accentColor) throws {
		let styledHTML = String("<span style=\"font-family: \(font.fontName); font-size: \(font.pointSize)\">\(html)</span>")
		
		try self.init(
			data: styledHTML.data(using: .unicode, allowLossyConversion: true)!,
			options: [
				.documentType: NSAttributedString.DocumentType.html, 
//				.characterEncoding: String.Encoding.utf8
			],
			documentAttributes: nil)

	}
}
