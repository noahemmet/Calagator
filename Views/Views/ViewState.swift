import Foundation

/// A generic enum representing one of three possible view states.
public enum ViewState<ViewModel> {
	case loading
	case success(ViewModel)
	case failure(String)
}
