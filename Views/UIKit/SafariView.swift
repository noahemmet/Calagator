import SwiftUI
import SafariServices

public struct SafariView: UIViewControllerRepresentable {
	public let url: URL
	
	public init(url: URL) {
		self.url = url
	}
	
	public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
		let vc = SFSafariViewController(url: url)
		return vc
	}
	
	public func updateUIViewController(_ uiViewController: SFSafariViewController,
									   context: UIViewControllerRepresentableContext<SafariView>) {
		// Nothing to do here.
	}
	
}
