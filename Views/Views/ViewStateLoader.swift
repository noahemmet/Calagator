import Foundation
import SwiftUI
import Combine

public protocol ViewModelInitializable: View {
	associatedtype ViewModel
	init(viewModel: ViewModel)
}

public struct ViewStateLoader<SuccessView: ViewModelInitializable>: View {
	
	public typealias ViewModel = SuccessView.ViewModel
	@State private var state: ViewState<ViewModel>
	private var fetcher: () -> ViewState<ViewModel>
	
	public init(_ viewModel: ViewModel, fetcher: @escaping () -> ViewState<ViewModel>) {
		_state = .init(initialValue: .success(viewModel))
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
				SuccessView.init(viewModel: viewModel)
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
