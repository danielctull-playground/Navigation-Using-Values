
import UIKit
import SwiftUI

final class ViewController: UIViewController {

    override func viewDidLoad() {

        let stack = UIStackView(arrangedSubviews: [
            Button(title: "Integer") { self.navigate(to: 100) },
            Button(title: "Bool") { self.navigate(to: true) },
            Button(title: "String") { self.navigate(to: "Hello") },
            Button(title: "Integer Link") { self.navigate(to: Link.integer(101)) },
            Button(title: "String Link") { self.navigate(to: Link.string("link string!")) },
        ])

        stack.alignment = .center
        stack.axis = .vertical
        stack.backgroundColor = .white

        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        view.centerYAnchor.constraint(equalTo: stack.centerYAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: stack.centerXAnchor).isActive = true
        view.backgroundColor = .white
    }
}

private final class Button: UIButton {
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:)") }
    init(title: String, action: @escaping () -> Void) {
        self.action = action
        super.init(frame: CGRect())
        self.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        setTitleColor(.gray, for: .highlighted)
    }

    let action: () -> Void
    @objc func performAction() { action() }
}
