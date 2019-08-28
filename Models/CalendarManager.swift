import EventKit
import Common

public class CalendarManager {
	public let store: EKEventStore
	
	@UserDefault(key: "CalendarEventIDsByEventIDs", defaultValue: [:])
	private var calendarEventIDsByEventIDs: [String: String]
	
	public init(store: EKEventStore = .init()) {
		self.store = store
	}
	
	public func addEvent(_ event: Event, completion: ((Error?) -> Void)?) {
		store.requestAccess(to: .event) { (granted, error) in
			guard error == nil, granted else {
				completion?(error ?? BasicError.reason("Calendar access not granted"))
				return
			}
			let calendarEvent = EKEvent(eventStore: self.store)
			calendarEvent.title = event.title
			calendarEvent.startDate = event.start
			calendarEvent.endDate = event.end
			//			calendarEvent.eventIdentifier = String(event.id)
			calendarEvent.calendar = self.store.defaultCalendarForNewEvents
			calendarEvent.notes = event.eventHTML
			calendarEvent.location = event.venue?.address.shortDisplay
			do {
				try self.store.save(calendarEvent, span: .thisEvent)
				self.calendarEventIDsByEventIDs[String(event.id)] = calendarEvent.eventIdentifier
			} catch let error {
				completion?(error)
				return
			}
			completion?(nil)
		}
	}
	
	public func removeEvent(_ event: Event, completion: ((Error?) -> Void)?) {
		store.requestAccess(to: .event) { (granted, error) in
			guard error == nil, granted else {
				completion?(error ?? BasicError.reason("Calendar access not granted"))
				return
			}
			guard let calendarEvent = self.calendarEvent(for: event) else {
				// Calendar event not found
				completion?(nil)
				return
			}
			do {
				try self.store.remove(calendarEvent, span: .thisEvent)
				self.calendarEventIDsByEventIDs[String(event.id)] = nil
			} catch let error {
				completion?(error)
				return
			}
			completion?(nil)
		}
	}
	
	public func calendarEvent(for event: Event) -> EKEvent? {
		guard let calendarEventID = calendarEventIDsByEventIDs[String(event.id)] else {
			return nil
		}
		let calendarEvent = store.event(withIdentifier: calendarEventID as String)
		return calendarEvent
	}
}
