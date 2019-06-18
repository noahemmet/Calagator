import Foundation

public enum ViewState<Model> {
	case loading
	case success(Model)
	case failure(String)
}
