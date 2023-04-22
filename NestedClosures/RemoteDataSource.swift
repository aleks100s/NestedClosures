import Combine

final class RemoteDataSource {
	var sampleData: AnyPublisher<String, Never> {
		sampleDataSubject.eraseToAnyPublisher()
	}
	
	private let sampleDataSubject = PassthroughSubject<String, Never>()
	
	func load() {
		sampleDataSubject.send("Result")
	}
}
