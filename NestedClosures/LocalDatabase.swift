import Foundation

final class LocalDatabase {
	func save(result: String, completion: @escaping () -> Void) {
		print(result)
		DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
			completion()
		}
	}
}
