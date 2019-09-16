import SwiftUI
import Models
import EventKit
import MapKit

public struct EventDetailView : View {
  public var event: Event
  
  @State private var showInSafari: Link?
  @State private var presentVenue: Bool = false
  @State private var showMapMenu: Bool = false
  
  public init(_ event: Event) {
    self.event = event
  }
  
  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 8) {
        // Title
        Text(event.title)
          .font(.title)
          .fixedSize(horizontal: false, vertical: true)
        
        Divider()
        
        // Time
        Button(action: self.addOrRemoveCalendar) {
          Field(header: "When", text: event.dateTimeDisplay, trailing: {
            if CalendarManager().calendarEvent(for: self.event) == nil {
              Image(systemSymbol: .calendarBadgePlus)
            } else {
              Image(systemSymbol: .calendarBadgeMinus)
            }
          })
        }
        
        Divider()
        
        // Event location
        if event.venue?.address != nil {
          NavigationLink(destination: VenueDetailView(venue: event.venue!), isActive: $presentVenue) {
            Field(header: "Where", text: event.venue?.addressDisplay, trailing: {
              Button(action: { self.showMapMenu = true }) {
                Image(systemSymbol: .arrowUpRightDiamond)
              }
            })
          }
          MapView(address: event.venue?.address?.shortDisplay)
            .frame(height: 240)
            .cornerRadius(8)
            .disabled(true)
          
          Divider()
        }
        
        // Event description
        Field(header: "What", text: event.eventDescription)
        
        // Links
        //			if self.event.links.isEmpty == false {
        //				Field(header: "Links", content: {
        //					ForEach(self.event.links) { link in
        //						Button(action: { self.showInSafari = link } ) {
        //							Text(link.name)
        //						}
        //					}
        //				})
        //			}
      }
      .padding()
    }
    .listStyle(PlainListStyle())
    .navigationBarItems(trailing:
      HStack(spacing: 16) {
        // Open in Safari
        Button(action: {
          self.showInSafari = Link(url: self.event.pageURL)
        }, label: {
          Image(systemSymbol: .safari)
        })
      }
      //			LabelView(html: event.eventHTML ?? "")
      //			Text(event.eventHTML ?? "")
      //				.font(.body)
      //				.lineLimit(nil)
    )
      .sheet(item: $showInSafari,
             content: { link in
              SafariView(url: link.url)
      })
      .actionSheet(isPresented: $showMapMenu) {
        ActionSheet(title: Text(event.venue?.addressDisplay ?? ""), message: nil, buttons: [
          .default(Text("Show in Maps"), action: { MapUtility.launchMaps(for: self.event.venue!.addressDisplay) }),
          .cancel(Text("Cancel"))
        ])
    }
  }
  private func addOrRemoveCalendar() {
    // Add/Remove from calendar
    let calendarManager = CalendarManager()
    if CalendarManager().calendarEvent(for: self.event) == nil {
      calendarManager.addEvent(self.event) { error in
        print(error as Any)
      }
    } else {
      calendarManager.removeEvent(self.event) { error in
        print(error as Any)
      }
    }
  }
}

struct EventDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      EventDetailView(.debug)
    }
  }
}
