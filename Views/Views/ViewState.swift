import Foundation

public enum ViewState<ViewModel> {
	case loading
	case success(ViewModel)
	case failure(String)
}
