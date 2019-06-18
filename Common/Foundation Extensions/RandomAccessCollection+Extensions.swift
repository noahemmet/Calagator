
public extension RandomAccessCollection where Index == Int {
	func element(at index: Int) -> Element? {
		guard index < self.count && index >= 0 else {
			return nil
		}
		return self[index]
	}
}
