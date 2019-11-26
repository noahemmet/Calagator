import SwiftUI
import Combine

public extension View {
  /// Presents an action sheet on iPhone only.
  func iPhoneActionSheet(isPresented: Binding<Bool>, title: Text, message: Text?, buttons: [ActionSheet.Button]) -> some View {
      if UIDevice.current.userInterfaceIdiom == .pad {
        return AnyView(self)
      } else {
        return AnyView(self.actionSheet(isPresented: isPresented, content: { ActionSheet(title: title, message: message, buttons: buttons) }))
    }
  }
}
