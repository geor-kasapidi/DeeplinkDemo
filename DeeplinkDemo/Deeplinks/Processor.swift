import Foundation

final class DeeplinkProcessor<ActionType> {
    typealias ConversionFunc = (URL) -> ActionType?
    typealias HandlerFunc = (ActionType, Bool) -> Bool

    private let queue = DispatchQueue(label: "n.seven.deeplink-processing")

    private let conversionFunc: ConversionFunc

    private var buffer: [ActionType] = []
    private var handlers: [HandlerFunc] = []

    init(conversionFunc: @escaping ConversionFunc) {
        self.conversionFunc = conversionFunc
    }

    func register(handler: @escaping HandlerFunc) {
        self.queue.async {
            self.handlers.append(handler)
            self.buffer = self.buffer.filter { !handler($0, false) }
        }
    }

    func handle(url: URL) -> Bool {
        guard let action = conversionFunc(url) else {
            return false
        }
        self.queue.async {
            if !self.handlers.reduce(false, { $0 || $1(action, $0) }) {
                self.buffer.append(action)
            }
        }
        return true
    }
}
