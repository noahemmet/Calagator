import SwiftUI
import Models

public struct EventRow : View {
  
  public var event: Event
  public var showDate: Bool = false
  
  /// Helps align the time stack
  private let timeWidth: CGFloat = 60
  
  public var body: some View {
    
    HStack(alignment: .firstTextBaseline, spacing: 8) {
      VStack(alignment: .trailing, spacing: 1) {
        // Show optional day
        if showDate {
          Text(event.dateDisplay)
            .font(.footnote)
            .foregroundColor(.primary)
        }
        
        // Start time
        Text(event.startTime)
          .font(.footnote)
          .foregroundColor(.primary)
        
        // End time
        Text(event.endTime)
          .font(.footnote)
          .foregroundColor(.secondary)
        
      }.frame(width: timeWidth)
      
      VStack(alignment: .leading) {
        // Title
        Text(event.title)
          .font(.body)
          .foregroundColor(.primary)
        // Summary
        Text(event.venue?.name ?? event.summary)
          .font(.footnote)
          .foregroundColor(.secondary)
          .lineLimit(2)
      }
    }
  }
}
