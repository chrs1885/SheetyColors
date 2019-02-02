**STRUCT**

# `SheetyColorsConfig`

```swift
public struct SheetyColorsConfig: SheetyColorsConfigProtocol
```

> A struct defining options for configuring a SheetyColors view.

## Properties
### `alphaEnabled`

```swift
public var alphaEnabled: Bool
```

> Defines whether an opacity slider should be displayed or not. Defaults to `true`.

### `hapticFeedbackEnabled`

```swift
public var hapticFeedbackEnabled: Bool
```

> Defines whether haptic feedback is supported when changing a slider's value. Defaults to `true`.

### `initialColor`

```swift
public var initialColor: UIColor
```

> The initial color used when displaying the SheetyColors view. Defaults to `.white`.

### `title`

```swift
public var title: String
```

> A title text displayed inside the SheetyColors view. Defaults to an empty string.

### `type`

```swift
public var type: SheetyColorsType
```

> The color model used by the SheetyColors view. Defaults to `.rgb`.

## Methods
### `init(alphaEnabled:hapticFeedbackEnabled:initialColor:title:type:)`

```swift
public init(alphaEnabled: Bool = true, hapticFeedbackEnabled: Bool = true, initialColor: UIColor = .white, title: String = "", type: SheetyColorsType = .rgb)
```

> Creates a SheetyColorsConfig instance.
>
> - Parameter:
> - red: The red component.
> - green: The green component.
> - blue: The blue component.
> - alpha: The opacity component.
