
import UIKit

final public class NavigationController: UINavigationController {

    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private var destinations: (Any) -> UIViewController? = { value in
        print("WARNING! NO ASSOCIATED VIEW CONTROLLER FOR VALUE: \(value)")
        return nil
    }

    /// Adds handling for
    ///
    /// - Parameters:
    ///   - value: The type of value supported by the destination.
    ///   - destination: A function that provides a view controller for the value.
    /// - Returns: The reconfigured ``NavigationController``.
    public func addDestination<Value>(
        for value: Value.Type,
        destination: @escaping (Value) -> UIViewController
    ) -> Self {

        let nav = self
        let existingDestinations = destinations
        nav.destinations = { value in
            guard let value = value as? Value else { return existingDestinations(value) }
            return destination(value)
        }
        return nav
    }

    fileprivate func _push<Value>(_ value: Value, animated: Bool) {
        guard let destination = destinations(value) else { return }
        pushViewController(destination, animated: animated)
    }
}

extension UIResponder {

    public func navigate<Value>(to value: Value, animated: Bool = true) {

        // Recurse up the responder chain to find the navigation controller.
        switch next {
        case .none: print("WARNING! NO NAVIGATION CONTROLLER FOUND")
        case .some(let nav as NavigationController): nav._push(value, animated: animated)
        case .some(let next): next.navigate(to: value, animated: animated)
        }
    }
}
