import SwiftUI

public struct Field<Content, Trailing>: View where Content: View, Trailing: View {
  public let header: String
  private let content: () -> Content
  private let trailing: (() -> Trailing)?
  
  public init(header: String, @ViewBuilder trailing: @escaping () -> Trailing, @ViewBuilder content: @escaping () -> Content) {
    self.header = header
    self.content = content
    self.trailing = trailing
  }
  
  public init(header: String, @ViewBuilder content: @escaping () -> Content) {
    self.header = header
    self.content = content
    self.trailing = nil
  }
  
  public var body: some View {
    HStack(spacing: 8) {
      VStack(alignment: .leading, spacing: 2) {
        Text(header)
          .font(.footnote)
          .foregroundColor(.secondary)
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
  
  public init(header: String, text: String?, @ViewBuilder trailing: @escaping () -> Trailing) {
    self.init(header: header, trailing: trailing) {
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
  public init(header: String, text: String?) {
    self.init(header: header) {
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
