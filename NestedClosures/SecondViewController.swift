import UIKit
import Combine

final class SecondViewController: UIViewController {
	private let remoteDataSource = RemoteDataSource()
	private let localDatabase = LocalDatabase()
	
	private var subscriptions = Set<AnyCancellable>()
		
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		observeOutput()
	}
	@IBAction func startLoading(_ sender: UIButton) {
		sender.isEnabled = false
		activityIndicator.startAnimating()
		remoteDataSource.load()
	}
	
	private func observeOutput() {
		remoteDataSource.sampleData
			.sink { [unowned self] value in // now there's no retain cycle
				self.localDatabase.save(result: value) { [weak self] in
					self?.activityIndicator.stopAnimating()
					self?.showAlert()
				}
			}
			.store(in: &subscriptions)
	}
		
	private func showAlert() {
		let alertViewController = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
		let action = UIAlertAction(title: "Go back", style: .cancel) { [weak self] _ in
			self?.dismiss(animated: true)
		}
		alertViewController.addAction(action)
		present(alertViewController, animated: true)
	}
}
