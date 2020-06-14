import UIKit

final class AlertViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        Deeplinks.processor.subscribe { [weak self] (action, eventWasHandledEarlier) -> Bool in
            guard !eventWasHandledEarlier, let self = self else {
                return false
            }

            switch action {
            case let .showAlert(title: title, subtitle: subtitle):
                DispatchQueue.main.async {
                    self.showAlert(title: title, subtitle: subtitle)
                }
                return true
            default:
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
