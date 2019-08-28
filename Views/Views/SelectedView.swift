import SwiftUI
import Common

public struct SelectedView<ViewSelection: ViewModelInitializable>: View {
	@Binding public var selection: ViewSelection.ViewModel?
	
	public init(_ selection: Binding<ViewSelection.ViewModel?>) {
		_selection = selection
	}
	
	public var body: some View {
		if let selection = selection {
			return AnyView {
				ViewSelection.init(selection)
			}
		} else {
			return AnyView {
				Text("No selection")
			}
		}
	}
}
