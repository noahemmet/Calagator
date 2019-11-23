import SwiftUI
import Combine
import FeedKit
import Models

/// Fetches events.
public class EventFetcher: ObservableObject {
	private static let cacheURL = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("eventsByDay")
	private static let url: URL = {
		if isFastlaneSnapshot {
			return Bundle.main.url(forResource: "Data/snapshot_data", withExtension: "atom")!
		} else {
			return URL(string: "http://calagator.org/events.atom")!
		}
	}() 
	
	@Published public var state: ViewState<EventStore> = .loading {
		willSet {
			//			if case .success = oldValue {
			//				return
			//			}
			self.objectWillChange.send()
		}
	}
	
	public init() { }
	
	public func fetch(useCache: Bool) {
		
		if useCache {
			DispatchQueue(label: "event cache").async {
				do {
					let cachedEvents = try self.getCachedEvents()
					DispatchQueue.main.async { [weak self] in
						guard let self = self else { return }
						self.state = .success(cachedEvents)
					}
				} catch {
					// Ignore cache errors
				}
			}
		}
		
		let parser = FeedParser(URL: EventFetcher.url)
		parser.parseAsync { result in
			
			switch result {
			case .atom(let feed):
				do {
					let events = try EventFetcher.events(from: feed.entries ?? [])
					let eventStore = EventStore(events: events)
					try self.store(eventStore)
					DispatchQueue.main.async { [weak self] in
						guard let self = self else { return }
						self.state = .success(eventStore)
					}
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
	
	private static func events(from atomEntries: [AtomFeedEntry]) throws -> [Event] {
		let events = try atomEntries.compactMap { try Event(atomEntry: $0) }
		let now = Date()
		let filtered = events.filter { $0.start >= now }
		return filtered
	}
	
	private func getCachedEvents() throws -> EventStore {
		let data = try FileManager.default.contents(atPath: EventFetcher.cacheURL.path).unwrap(orThrow: "No cached events found")
		let decoder = JSONDecoder()
		let eventStore = try decoder.decode(EventStore.self, from: data)
		let now = Date()
		let filtered = eventStore.removingPastEvents(after: now)
		return filtered
	}
	
	private func store(_ eventStore: EventStore) throws {
		let encoder = JSONEncoder()
		let data = try encoder.encode(eventStore)
		FileManager.default.createFile(atPath: EventFetcher.cacheURL.path, contents: data, attributes: nil)
	}
	
}
