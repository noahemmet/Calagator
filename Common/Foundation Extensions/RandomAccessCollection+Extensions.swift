
public extension RandomAccessCollection where Index == Int {
	func element(at index: Int) -> Element? {
		guard index < self.count && index >= 0 else {
			return nil
		}
		return self[index]
	}
	
	func keyed<Key: Hashable>(by closure: (Element) throws -> Key ) rethrows -> [Key: [Element]] {
		return try self.reduce([:]) { result, element in
			var result = result
			let key = try closure(element)
			result[key, default: []].append(element)
			return result
		}
	}
}
