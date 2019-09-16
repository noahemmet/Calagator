import SwiftUI

public struct Field<Content, Trailing>: View where Content: View, Trailing: View {
  public let header: String
  private let headerColor: Color
  private let content: () -> Content
  private let trailing: (() -> Trailing)?
  
  public init(header: String, headerColor: Color = .secondary, @ViewBuilder trailing: @escaping () -> Trailing, @ViewBuilder content: @escaping () -> Content) {
    self.header = header
    self.headerColor = headerColor
    self.content = content
    self.trailing = trailing
  }
  
  public init(header: String, headerColor: Color = .secondary, @ViewBuilder content: @escaping () -> Content) {
    self.header = header
    self.headerColor = headerColor
    self.content = content
    self.trailing = nil
  }
  
  public var body: some View {
    HStack(spacing: 8) {
      VStack(alignment: .leading, spacing: 2) {
        Text(header)
          .font(.footnote)
          .foregroundColor(headerColor)
        content()
          .fixedSize(horizontal: false, vertical: true)
      }
      .layoutPriority(1) // Makes sure the content sizes correctly.
      Spacer()
      trailing?()
    }
  }
}

// TODO: I think there's a way to do this while constrained to a ViewModifier
extension Field where Content == AnyView {
  
  public init(header: String, headerColor: Color = .secondary, text: String?, @ViewBuilder trailing: @escaping () -> Trailing) {
    self.init(header: header, headerColor: headerColor, trailing: trailing) {
      AnyView(
        Text(text ?? "")
          .font(.body)
          .foregroundColor(.primary)
          .lineLimit(Int.max) // nil wasn't wrapping correctly
      )
    }
  }
}

extension Field where Content == AnyView, Trailing == EmptyView {
  public init(header: String, headerColor: Color = .secondary, text: String?) {
    self.init(header: header, headerColor: headerColor) {
      AnyView(
        Text(text ?? "")
          .font(.body)
          .foregroundColor(.primary)
          .lineLimit(Int.max) // nil wasn't wrapping correctly
      )
    }
  }
}

struct Field_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading, spacing: 20) {
      Field(header: "Long Text Header", text: "Text Text Text Text Text\nText Text Text Text Text Text Text Text Text Text") {
        Text("i")
      }
      Field(header: "Short Text Header", text: "Text Text Text") {
        Text("i")
      }
    }
  }
}
