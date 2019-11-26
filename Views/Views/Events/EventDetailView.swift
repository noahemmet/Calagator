import SwiftUI
import Models
import EventKit
import MapKit

public struct EventDetailView : View {
  public var event: Event
  
  @State private var showInSafari: Link?
  @State private var presentVenue: Bool = false
  @State private var showMapMenu: Bool = false
  @State private var showCalendarAlert: Bool = false
  
  private let calendarManager = CalendarManager()
  @State private var isEventInCalendar: Bool
  
  public init(_ event: Event) {
    self.event = event
    _isEventInCalendar = .init(initialValue: calendarManager.calendarEvent(for: event) != nil)
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
        Field(header: "When", text: event.dateTimeDisplay) {
          Button(action: { self.showCalendarAlert = true }) {
            if CalendarManager().calendarEvent(for: self.event) == nil {
              Image(systemSymbol: .calendarBadgePlus)
            } else {
              Image(systemSymbol: .calendarBadgeMinus)
                .accentColor(.red)
            }
          }
        }
        
        Divider()
        
        // Event location
        if event.venue?.address != nil {
          NavigationLink(destination: VenueDetailView(venue: event.venue!), isActive: $presentVenue) {
            Field(header: "Where", headerColor: .accentColor, text: event.venue?.addressDisplay) {
              Button(action: {
                if UIDevice.current.userInterfaceIdiom == .pad {
                  MapUtility.launchMaps(for: self.event.venue!.addressDisplay)
                } else {
                  self.showMapMenu = true
                }
              }) {
                Image(systemSymbol: .arrowUpRightDiamond)
              }
            }
          }
          MapView(address: event.venue?.address?.shortDisplay)
            .frame(height: 240)
            .cornerRadius(8)
            .disabled(true)
          
          Divider()
        }
        
        // Event description
        Field(header: "What", text: event.eventDescription)
        
//        LabelView(html: event.eventHTML ?? "", fallback: event.eventDescription ?? "")
//          .fixedSize(horizontal: true, vertical: true)
//        Text(event.eventHTML ?? "")
//          .font(.body)
//          .fixedSize(horizontal: false, vertical: true)
        
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
    )
      .sheet(item: $showInSafari,
             content: { link in
              SafariView(url: link.url)
      })
      
      .iPhoneActionSheet(
        isPresented: $showMapMenu,
        title: Text(self.event.venue!.addressDisplay),
        message: nil,
        buttons: [
          .default(Text("Open in Maps")) {
            MapUtility.launchMaps(for: self.event.venue!.addressDisplay)
          },
          .cancel()
      ])
    .alert(isPresented: $showCalendarAlert) {
      if isEventInCalendar {
        return Alert(title: Text("Remove from Calendar"),
                     primaryButton: .default(Text("Remove"), action: addOrRemoveCalendar),
                     secondaryButton: .cancel())
      } else {
        return Alert(title: Text("Add to Calendar"),
                     primaryButton: .default(Text("Add"), action: addOrRemoveCalendar ),
                     secondaryButton: .cancel())
      }
    }
  }
  
  private func addOrRemoveCalendar() {
    // Add/Remove from calendar
    // We set `isEventInCalendar` manually to avoid EventKit/Combine messiness.
    if isEventInCalendar {
      calendarManager.removeEvent(self.event) { error in
        guard error == nil else {
          print(error as Any)
          return
        }
        self.isEventInCalendar = false
      }
    } else {
      calendarManager.addEvent(self.event) { error in
        guard error == nil else {
          print(error as Any)
          return
        }
        self.isEventInCalendar = true
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
