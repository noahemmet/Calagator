
public enum UnwrapError<K>: Error {
	case failed(type: K)
	case badValue(Any, type: K)
}

// The closure is at the end so as to get the trailing closure sugar.
public func unwrap<K>(file: String = #file, line: Int = #line, function: String = #function, _ closure: () throws -> K?) throws -> K {
	guard let unwrapped = try closure() else {
		throw ThrownError(UnwrapError.failed(type: K.self), file: file, line: line, function: function)
	}
	return unwrapped
}

public func unwrap<K>(orThrow error: Error, _ closure: () throws -> K?) throws -> K {
	guard let unwrapped = try closure() else {
		throw error
	}
	return unwrapped
}

public extension Optional {
	func unwrap(file: String = #file, line: Int = #line, function: String = #function) throws -> Wrapped {
		guard let unwrapped = self else {
			throw ThrownError(UnwrapError.failed(type: self), file: file, line: line, function: function)
		}
		return unwrapped
	}
	
	func unwrap(orThrow error: @autoclosure () -> Error) throws -> Wrapped {
		guard let unwrapped = self else {
			throw error()
		}
		return unwrapped
	}
	
	func unwrap(file: String = #file, line: Int = #line, function: String = #function, orThrow reason: String) throws -> Wrapped {
		guard let unwrapped = self else {
			throw ThrownError(reason, file: file, line: line, function: function)
		}
		return unwrapped
	}
}

public extension Optional where Wrapped == String {
	var isEmptyOrNil: Bool {
		if case let .some(string) = self, string.isEmpty == false {
			return false
		} else {
			return true
		}
	}
}
