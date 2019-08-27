import Foundation
import SwiftUI
import Combine

//public struct ViewStateView<ViewModel>: View {
//	public typealias State = ViewState<ViewModel>
//	@Binding public var state: State
//	
//	public init(state: Binding<State>, @ViewBuilder viewForModel: (ViewModel) -> View) {
//		_state = state
//		viewForModel(.loading)
//	}
//	
//	private var stateView: AnyView {
//		switch state {
//		case .loading:
//			return AnyView(
//				Text("Loading…")
//			)
//		case .success(let eventsByDay):
//			return AnyView(
//				EventsView(allEventsByDay: eventsByDay)
//			)
//		case .failure(let error):
//			return AnyView(
//				Text(error)
//			)
//		}
//	}
//	
//	public var body: some View {
//		
//	}
//}
