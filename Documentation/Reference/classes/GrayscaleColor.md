**CLASS**

# `GrayscaleColor`

```swift
public class GrayscaleColor: NSObject, NSCopying, Codable
```

> A model class representing grayscale colors. The white component can hold values between 0.0 and 255.0 while the alphavalue has a maximum value of 100.0.

## Methods
### `init(white:alpha:)`

```swift
public init(white: CGFloat, alpha: CGFloat)
```

> Creates a GrayscaleColor instance.
>
> - Parameter:
> - white: The white component.
> - alpha: The opacity component.

### `copy(with:)`

```swift
public func copy(with _: NSZone? = nil) -> Any
```

> Creates a copy of the GrayscaleColor instance.
>
> - Returns: A copy of the GrayscaleColor instance.

### `isEqual(_:)`

```swift
public override func isEqual(_ object: Any?) -> Bool
```

> Compares two GrayscaleColor instances with each other.
>
> - Parameter object: The GrayscaleColor to compare with.
>
> - Returns: 'true' if the instance is equal to the other GrayscaleColor instance, otherwise 'false''.

#### Parameters

| Name | Description |
| ---- | ----------- |
| object | The GrayscaleColor to compare with. |