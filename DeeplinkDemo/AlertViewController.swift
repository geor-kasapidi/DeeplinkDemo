import UIKit

final class AlertViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        Deeplinks.processor.register { [weak self] (action, wasProcessed) -> Bool in
            guard let self = self, !wasProcessed else {
                return false
            }

            switch action {
            case let .showAlert(title: title, subtitle: subtitle):
                DispatchQueue.main.async {
                    self.showAlert(title: title, subtitle: subtitle)
                }
                return true
            case .setupDefaults:
                return false
            }
        }
    }

    private func showAlert(title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(.init(title: "Close", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
