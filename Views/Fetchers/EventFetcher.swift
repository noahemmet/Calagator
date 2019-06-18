import SwiftUI
import Combine
import FeedKit
import Models

public class EventFetcher: BindableObject {
	private static let url = Bundle.main.url(forResource: "Data/example_data", withExtension: "atom")!
	
	public var didChange = PassthroughSubject<EventFetcher, Never>()
	
	public var state: ViewState<[EventsByDay]> = .loading {
		didSet {
//			if case .success = oldValue {
//				return
//			}
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
				do {
					let events = try EventFetcher.events(from: feed.entries ?? [])
					let eventsByDay = EventsByDay.from(events: events)
					self.state = .success(eventsByDay)
				} catch let error {
					self.state = .failure(error.localizedDescription)
				}
			case .failure(let error):
				self.state = .failure(error.localizedDescription)
			default:
				self.state = .failure("Unrecognized data")
			}
		}
	}
	
	static func events(from atomEntries: [AtomFeedEntry]) throws -> [Event] {
		let events = try atomEntries.compactMap { try Event(atomEntry: $0) }
		return events
	}
}
