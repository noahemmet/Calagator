import Foundation

public protocol SortedEvents {
  var id: Date { get }
  var dateString: String { get }
  var events: [Event] { get }
}
