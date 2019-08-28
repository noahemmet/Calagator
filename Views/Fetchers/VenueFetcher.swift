import SwiftUI
import Combine
import FeedKit
import Models

/// Fetches venues.
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
	}
}
