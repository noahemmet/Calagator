import Foundation

/// A collection of events, sorted by some method.
public protocol SortedEvents {
  var id: Date { get }
  var dateString: String { get }
  var events: [Event] { get }
}
