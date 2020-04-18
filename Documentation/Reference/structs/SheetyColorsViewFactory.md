**STRUCT**

# `SheetyColorsViewFactory`

```swift
public struct SheetyColorsViewFactory
```

> A factory for creating SheetyColors view controller

## Methods
### `createView(withConfig:delegate:)`

```swift
public static func createView(withConfig config: SheetyColorsConfigProtocol, delegate: SheetyColorsDelegate? = nil) -> SheetyColorsViewController
```

> Creates a SheetyColorsViewController instance based on a given configuration.
>
> - Parameter:
> - config: Defines all aspects of the view such as a color model type, alpha value support, texts, initial colors, or haptical feedback.
> - delegate: A delegate used for handling the color selection. A delegate needs to be provided in cases where you want to use the SheetyColorsViewController directly and not as part of a UIAlertViewController (e.g. SwiftUI).
>
> - Returns: A SheetyColorsViewController instance.
