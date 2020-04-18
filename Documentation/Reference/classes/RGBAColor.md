**CLASS**

# `RGBAColor`

```swift
public class RGBAColor: NSObject, NSCopying, Codable
```

> A model class representing RGBA colors. The red, green, and blue component can hold values between 0.0 and 255.0 while the alpha value has a maximum value of 100.0.

## Methods
### `init(red:green:blue:alpha:)`

```swift
public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
```

> Creates a RGBAColor instance.
>
> - Parameter:
> - red: The red component.
> - green: The green component.
> - blue: The blue component.
> - alpha: The opacity component.

### `copy(with:)`

```swift
public func copy(with _: NSZone? = nil) -> Any
```

> Creates a copy of the RGBAColor instance.
>
> - Returns: A copy of the RGBAColor instance.

### `isEqual(_:)`

```swift
public override func isEqual(_ object: Any?) -> Bool
```

> Compares two RGBAColor instances with each other.
>
> - Parameter object: The RGBAColor to compare with.
>
> - Returns: 'true' if the instance is equal to the other RGBAColor instance, otherwise 'false''.

#### Parameters

| Name | Description |
| ---- | ----------- |
| object | The RGBAColor to compare with. |