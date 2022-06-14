
import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = NavigationController(rootViewController: ViewController())
            .addDestination(for: Int.self) { value in                                // A destination is a fucntion that
                UIHostingController(rootView: IntView(value: value))                 // provides a view contorller for a
            }                                                                        // given value.
            .addDestination(for: Bool.self) { value in                               //
                UIHostingController(rootView: BoolView(value: value))                // This is typed, so the closure is
            }                                                                        // only called with that type of
            .addDestination(for: Link.self) { link in                                // value.
                switch link {                                                        //
                case let .string(string):                                            // Any type of value can be used,
                    return UIHostingController(rootView: StringView(value: string))  // so can also use an enum which
                case let .integer(integer):                                          // could be used to represent
                    return UIHostingController(rootView: IntView(value: integer))    // deeplinks?
                }
            }
    }
}

enum Link {
    case string(String)
    case integer(Int)
}

struct IntView: View {
    let value: Int
    var body: some View {
        VStack {
            Text("IntView")
                .font(.title)
            Text("Value: \(value)")
        }
    }
}

struct BoolView: View {
    let value: Bool
    var body: some View {
        VStack {
            Text("BoolView")
                .font(.title)
            Text("Value: \(value ? "true" : "false")")
        }
    }
}

struct StringView: View {
    let value: String
    var body: some View {
        VStack {
            Text("StringView")
                .font(.title)
            Text("Value: \(value)")
        }
    }
}
