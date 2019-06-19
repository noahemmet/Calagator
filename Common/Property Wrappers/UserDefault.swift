
@propertyDelegate
public struct UserDefault<T> {
	public let key: String
	public let defaultValue: T
	
	public init(key: String, defaultValue: T) {
		self.key = key
		self.defaultValue = defaultValue
	}
	
	public var value: T {
		get {
			return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
		}
		set {
			UserDefaults.standard.set(newValue, forKey: key)
		}
	}
}
