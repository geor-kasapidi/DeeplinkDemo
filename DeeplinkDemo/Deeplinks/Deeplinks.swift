import UIKit

enum Deeplinks {
    enum Action {
        case showAlert(title: String, subtitle: String)
        case setupDefaults(key: String, value: String)
    }

    static let processor = DeeplinkProcessor<Action>(conversionFunc: actionFrom(url:))

    private static func actionFrom(url: URL) -> Action? {
        guard url.scheme == "lol-kek" else {
            return nil
        }

        let queryItems = (URLComponents(url: url, resolvingAgainstBaseURL: false).flatMap { $0.queryItems } ?? []).reduce(into: [String: String]()) { $0[$1.name] = $1.value }

        switch url.host {
        case "alert":
            if let title = queryItems["title"], let subtitle = queryItems["subtitle"] {
                return .showAlert(title: title, subtitle: subtitle)
            }
        case "defaults":
            if let key = queryItems["key"], let value = queryItems["value"] {
                return .setupDefaults(key: key, value: value)
            }
        default:
            break
        }

        return nil
    }
}
