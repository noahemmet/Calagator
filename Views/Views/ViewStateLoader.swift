import Foundation
import SwiftUI
import Combine

/// Depicts a View that can be initialized from some view model.
public protocol ViewModelInitializable: View {
	associatedtype ViewModel
	init(_ viewModel: ViewModel)
}

/// Loads a generic view.
/// TODO: This needs better Combine integration.
public struct ViewStateLoader<SuccessView: ViewModelInitializable>: View {
	
	public typealias ViewModel = SuccessView.ViewModel
	@State private var state: ViewState<ViewModel>
	private var fetcher: () -> ViewState<ViewModel>
	
	public init(_ viewModel: ViewModel, fetcher: @escaping () -> ViewState<ViewModel>) {
		_state = .init(initialValue: .success(viewModel))
		self.fetcher = fetcher
	}
	
	public init(fetcher: @escaping () -> ViewState<ViewModel>) {
		_state = .init(initialValue: .loading)
		self.fetcher = fetcher
	}
	
	public func fetch() {
		self.state = self.fetcher()
	}
	
	private var stateView: AnyView {
		switch state {
		case .loading:
			return AnyView(
				Text("Loading…")
			)
		case .success(let viewModel):
			return AnyView(
				SuccessView.init(viewModel)
			)
		case .failure(let error):
			return AnyView(
				Text(error)
			)
		}
	}

	public var body: some View {
		return stateView
	}
}
