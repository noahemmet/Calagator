import SwiftUI
import Combine
import FeedKit
import Models

public class EventFetcher: BindableObject {
	private static let url = Bundle.main.url(forResource: "Data/example_data", withExtension: "atom")!
	
	public var didChange = PassthroughSubject<EventFetcher, Never>()
	
	public var state: ViewState<[Event]> = .loading {
		didSet {
			DispatchQueue.main.async { [weak self] in
				guard let self = self else { return }
				self.didChange.send(self)
			}
		}
	}
	
	public init() {
		let parser = FeedParser(URL: EventFetcher.url)
		parser.parseAsync { result in
			switch result {
			case .atom(let feed):
				let events = feed.entries?.compactMap { Event(atomEntry: $0) } ?? []
				self.state = .success(events)
			case .failure(let error):
				self.state = .failure(error.localizedDescription)
			default:
				self.state = .failure("Unrecognized data")
			}
		}
	}
}
