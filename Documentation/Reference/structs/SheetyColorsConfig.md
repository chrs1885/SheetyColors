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

> Defines whether an opacity slider should be displayed or not.

### `hapticFeedbackEnabled`

```swift
public var hapticFeedbackEnabled: Bool
```

> Defines whether haptic feedback is supported when changing a slider's value.

### `initialColor`

```swift
public var initialColor: UIColor
```

> The initial color used when displaying the SheetyColors view.

### `message`

```swift
public var message: String?
```

> A description text displayed inside the SheetyColors view.

### `title`

```swift
public var title: String?
```

> A title text displayed inside the SheetyColors view.

### `type`

```swift
public var type: SheetyColorsType
```

> The color model used by the SheetyColors view.

## Methods
### `init(alphaEnabled:hapticFeedbackEnabled:initialColor:title:message:type:)`

```swift
public init(alphaEnabled: Bool = true, hapticFeedbackEnabled: Bool = true, initialColor: UIColor = .white, title: String? = nil, message: String? = nil, type: SheetyColorsType = .rgb)
```

> Creates a SheetyColorsConfig instance.
>
> - Parameter:
> - alphaEnabled: Defines whether an opacity slider should be displayed or not. Defaults to `true`.
> - hapticFeedbackEnabled: Defines whether haptic feedback is supported when changing a slider's value. Defaults to `true`.
> - initialColor: The initial color used when displaying the SheetyColors view. Defaults to `.white`.
> - title: A title text displayed inside the SheetyColors view. Defaults to `nil`.
> - message: A description text displayed inside the SheetyColors view. Defaults to `nil`.
> - type: The color model used by the SheetyColors view. Defaults to `.rgb`.
