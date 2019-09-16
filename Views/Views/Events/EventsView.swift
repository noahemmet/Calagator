import SwiftUI
import Models

public struct EventsView : View {
  public var eventStore: EventStore
  @State private var sortMethod: EventStore.SortMethod = .byDay
  
  public var body: some View {
    List {
      // Lets you sort by upcoming and recently added
      Picker(selection: $sortMethod, label: Text("Sort Events")) {
        Text("Upcoming")
          .tag(EventStore.SortMethod.byDay)
        Text("Recently Added")
          .tag(EventStore.SortMethod.byPublished)
      }.pickerStyle(SegmentedPickerStyle())
      
      ForEach(eventStore.sortedEvents(for: sortMethod), id: \.id) { sortedEvents in
        Section(header: Text(sortedEvents.dateString).font(.headline)) {
          ForEach(sortedEvents.events) { event in
            NavigationLink(destination: EventDetailView(event)) {
              EventRow(event: event)
            }
          }
        }
      }
    }
    .listStyle(GroupedListStyle())
  }
}

struct EventsView_Previews : PreviewProvider {
  static let start = Date()
  static let end = start.addingTimeInterval(60*60)
  static let tomorrowStart = Date().addingTimeInterval(60*60*24)
  static let tomorrowEnd = tomorrowStart.addingTimeInterval(60*60)
  static let published = start.addingTimeInterval(-60*60)
  
  static var previews: some View {
    NavigationView {
      EventsView(eventStore: EventStore(events: [
        .init(id: 0, title: "Event 1", summary: "Event Summary", published: Date(), start: start, end: end),
        .init(id: 1, title: "Event 2", summary: "Event Summary", published: published, start: tomorrowStart, end: tomorrowEnd),
      ]))
    }
  }
}
