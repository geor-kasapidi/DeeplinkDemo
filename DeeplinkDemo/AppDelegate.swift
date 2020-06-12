import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Deeplinks.processor.register { (action, _) -> Bool in
            switch action {
            case let .setupDefaults(key: key, value: value):
                UserDefaults.standard.set(value, forKey: key)
                return false
            default:
                return false
            }
        }

        let wnd = UIWindow()
        wnd.rootViewController = LoadingViewController()

        self.window = wnd

        wnd.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            wnd.rootViewController = AlertViewController()
        }

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return Deeplinks.processor.handle(url: url)
    }
}
