import SwiftUI
import Combine

public final class Device: ObservableObject {
	@Published public var isLandscape: Bool
	
	public init(isLandscape: Bool) { 
		self.isLandscape = isLandscape
	}
}

struct DeviceKey: EnvironmentKey {
	static let defaultValue: Device = Device(isLandscape: true)
}

extension EnvironmentValues {
	public var device: Device {
		get {
			return self[DeviceKey.self]
		}
		set {
			self[DeviceKey.self] = newValue
		}
	}
}
