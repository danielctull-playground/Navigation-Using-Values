# Navigation Using Values

This project demonstrates how one could use values to perform navigation in a similar-ish API to how SwiftUI's new `NavigationStack` works.

## How the API works

### Configure the NavigationController

Use the `addDestination(for:destination:)` API to add handlers for value types. These are typed, so `value` in this example is always a `String`.

```swift
NavigationController(rootViewController: ViewController())
  .addDestination(for: String.self) { value in
    UIHostingController(rootView: StringView(value: value))
  }      
```

This acts as a stack where the last definition for a value type wins – for example if another addDestination call occured after this also handling a String type, that latter definition would be used instead.

### Send values from view controller

From a view controller (or any responder in the responder chain) you can then call `navigate(to:)` providing the value you wish to nagivate to.

```swift
// Inside a view controller

Button(title: “Show Hello World") {
  self.navigate(to: “Hello World!")
}
```

## Testing

Instead of using Mocks, you could use a proper `NavigationController` with custom destination handlers to verify that the correct values come out when performing actions.

## Implementation Alternatives

### Intercepting View Controller

There are alternative methods for handling the destination creation. Another idea might be to have a private view controller that acts as a parent to, but adds the destination creation in the responder chain. In this way, as the call to `navigate(to:)` goes up the responder chain it can intercepted by one of these destination creator view controllers to create the destination view controller and push that on a vanilla `UINavigationController`.