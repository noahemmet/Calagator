import SwiftUI
import Combine
import FeedKit
import Models

public class VenueFetcher: ObservableObject {
		
	//	private static let url = Bundle.main.url(forResource: "Data/example_data", withExtension: "atom")!
	private static let url = URL(string: "https://calagator.org/venues.json")!
	
	@Published public var state: ViewState<[Venue]> = .loading {
		willSet {
			//			if case .success = oldValue {
			//				return
			//			}
			self.objectWillChange.send()
		}
	}
	
	public init() { }
	
	public func fetch() {
		URLSession.shared.dataTask(with: VenueFetcher.url) { (data, response, error) in
			do {
				guard let data = data else { return }
				let string = String(data: data, encoding: .utf8)!

				let venues = try JSONDecoder().decode([Venue].self, from: data)
				DispatchQueue.main.async {
					self.state = .success(venues)
				}
			} catch {
				DispatchQueue.main.async {
					self.state = .failure(error.localizedDescription)
				}
			}
		}.resume()

//		let parser = FeedParser(URL: EventFetcher.url)
//		parser.parseAsync { result in
//			switch result {
//			case .atom(let feed):
//				do {
//					let events = try EventFetcher.events(from: feed.entries ?? [])
//					let eventsByDay = EventsByDay.from(events: events)
//					DispatchQueue.main.async { [weak self] in
//						guard let self = self else { return }
//						self.state = .success(eventsByDay)
//					}
//				} catch let error {
//					self.state = .failure(error.localizedDescription)
//				}
//			case .failure(let error):
//				self.state = .failure(error.localizedDescription)
//			default:
//				self.state = .failure("Unrecognized data")
//			}
//		}
	}
	
//	static func venues(from atomEntries: [AtomFeedEntry]) throws -> [Event] {
//		let events = try atomEntries.compactMap { try Event(atomEntry: $0) }
//		return events
//	}
}
