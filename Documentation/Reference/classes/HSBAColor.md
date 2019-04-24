**CLASS**

# `HSBAColor`

```swift
public class HSBAColor: NSObject, NSCopying, Codable
```

> A model class representing HSBA colors. The hue component can hold values between 0.0 and 360.0 while the saturation and brightnes values have a maximum value of 100.0.

## Methods
### `init(hue:saturation:brightness:alpha:)`

```swift
public init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)
```

> Creates a HSBAColor instance.
>
> - Parameter:
> - hue: The hue component.
> - saturation: The saturation component.
> - brightness: The brightness component.
> - alpha: The opacity component.

### `copy(with:)`

```swift
public func copy(with _: NSZone? = nil) -> Any
```

> Creates a copy of the HSBAColor instance.
>
> - Returns: A copy of the HSBAColor instance.

### `isEqual(_:)`

```swift
public override func isEqual(_ object: Any?) -> Bool
```

> Compares two HSBAColor instances with each other.
>
> - Parameter object: The HSBAColor to compare with.
>
> - Returns: 'true' if the instance is equal to the other HSBAColor instance, otherwise 'false''.

#### Parameters

| Name | Description |
| ---- | ----------- |
| object | The HSBAColor to compare with. |