import Foundation
import UIKit

final class LoadingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .black

        view.addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        spinner.startAnimating()
    }
}
