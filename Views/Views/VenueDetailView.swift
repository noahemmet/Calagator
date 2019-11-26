import SwiftUI
import Models

public struct VenueDetailView: View {
  public let venue: Venue
  @State private var showInSafari: Link?
  @State private var showMapMenu: Bool = false
  
  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 8) {
        // Header
        Text(venue.name)
          .font(.title)
          .fixedSize(horizontal: false, vertical: true)
        
        Divider()
        
        if venue.address != nil {
          VStack {
            Field(header: "Address", text: venue.address?.shortDisplay, trailing: {
              Button(action: { self.showMapMenu = true }) {
                Image(systemSymbol: .arrowUpRightDiamond)
              }
            })
            MapView(address: self.venue.address?.shortDisplay)
              .frame(height: 240)
              .cornerRadius(8)
          }
        
          Divider()
        }
        
        EventsView(eventStore: EventStore(byDay: venue.eventsByDay, byPublished: []))
      }
      .padding()
    }
    .navigationBarItems(trailing:
      HStack(spacing: 16) {
        // Open in Safari
        Button(action: {
          self.showInSafari = Link(url: self.venue.pageURL)
        }, label: {
          Image(systemSymbol: .safari)
        })
      })
      .iPhoneActionSheet(
        isPresented: $showMapMenu,
        title: Text(self.venue.addressDisplay),
        message: nil,
        buttons: [
          .default(Text("Open in Maps")) {
            MapUtility.launchMaps(for: self.venue.addressDisplay)
          },
          .cancel()
      ])
      
    .sheet(item: $showInSafari,
           content: { link in
            SafariView(url: link.url)
    })
  }
}

struct VenueDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VenueDetailView(venue: Venue(id: 0, name: "Venue Name", description: "description", address: .debug))
    }
  }
}
