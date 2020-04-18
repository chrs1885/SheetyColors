**PROTOCOL**

# `SheetyColorsDelegate`

```swift
public protocol SheetyColorsDelegate: AnyObject
```

> A protocol defining functions that are called when interacting with a color picker.

## Methods
### `didSelectColor(_:)`

```swift
func didSelectColor(_ color: UIColor)
```

> A delegate function that gets called once any slider value has been changed.
>
> - Parameter:
> - color: The updated color.
