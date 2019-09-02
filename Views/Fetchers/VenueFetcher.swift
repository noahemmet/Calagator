import SwiftUI
import Combine
import FeedKit
import Models

/// Fetches venues.
public class VenueFetcher: ObservableObject {
	private static let cacheURL = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("venues")
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
	
	func fetch(useCache: Bool) {
		
		if useCache {
			DispatchQueue(label: "event cache").async {
				do {
					let venues = try self.getCachedVenues()
					DispatchQueue.main.async { [weak self] in
						guard let self = self else { return }
						self.state = .success(venues)
					}
				} catch {
					// Ignore cache errors
				}
			}
		}
		
		URLSession.shared.dataTask(with: VenueFetcher.url) { (data, response, error) in
			do {
				guard let data = data else { return }
				
				let venues = try JSONDecoder().decode([Venue].self, from: data)
				try self.store(venues)
				DispatchQueue.main.async {
					self.state = .success(venues)
				}
			} catch {
				DispatchQueue.main.async {
					self.state = .failure(error.localizedDescription)
				}
			}
		}.resume()
	}
	
	private func getCachedVenues() throws -> [Venue] {
		let data = try FileManager.default.contents(atPath: VenueFetcher.cacheURL.path).unwrap(orThrow: "No cached venues found")
		let decoder = JSONDecoder()
		let venues = try decoder.decode([Venue].self, from: data)
		return venues
	}
	
	private func store(_ venues: [Venue]) throws {
		let encoder = JSONEncoder()
		let data = try encoder.encode(venues)
		FileManager.default.createFile(atPath: VenueFetcher.cacheURL.path, contents: data, attributes: nil)
	}
}
