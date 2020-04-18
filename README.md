![Cocoapods(https://cocoapods.org/pods/SheetyColors)](https://img.shields.io/cocoapods/v/SheetyColors.svg)
[![Carthage compatible](https://img.shields.io/badge/carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
![UIKit & SwiftUI](https://img.shields.io/badge/iOS-UIKit%20%26%20SwiftUI-yellow)
![iOS 13 Ready](https://img.shields.io/badge/iOS%2013-Ready-blueviolet)
![Swift](https://img.shields.io/badge/swift-5.0-red.svg)
[![Build Status](https://app.bitrise.io/app/e955e72e7da4b8c0/status.svg?token=wOm6zBpCFw7ZeP8gJdDE_A&branch=develop)](https://app.bitrise.io/app/e955e72e7da4b8c0)
[![Twitter](https://img.shields.io/badge/twitter-%40chr__wendt-58a1f2.svg)](https://twitter.com/chr_wendt)

<p align="center">
  <img src="./Documentation/sheetycolors.png" width="400">
</p>

**SheetyColors** is an action sheet styled color picker for iOS:

- 📱 **Based on UIAlertController:** The SheetyColors API is based on UIKit's `UIAlertController`. Simply add buttons to it as you would for any other Action Sheet by defining `UIAlertAction` instances. Therefore, it nicely integrates with the look & feel of all other native system dialogs. However, you can also chose to use the color picker it self without an action sheet.
- 🎨 **Fully configurable:** You can choose between a variety of configurations such as 
	- color model (RGB, HSB, or Grayscale)
	- alpha component support
	- haptic feedback
	- text/message label
- 🎚️ **Sliders and Hex input:** You can create new colors by either using sliders or the newly added Hex input.
- 👶 **Intuitive UI:** Each slider comes with a gradient that gives you an idea of how changing individual slider values affects the resulting color. All controls do support haptic feedback and will react to any errors such as invalid Hex values.
- 🍏 **SwiftUI & iOS 13 support:** SheetyColors can also be used as part of your SwiftUI projects. Have a look at the *Usage* section to get further info. The library is also optimized to work well with the new Dark Mode.

| NEW: Hex input |RGB, HSB, and Grayscale|Fully configurable|Dark mode support|
| :-: | :-: | :-: | :-: |
|![Color picker supporting RGB, HSB, and Grayscale][hex_input]|![Color picker supporting RGB, HSB, and Grayscale][minimum_config]|![Fully configurable][fully_configurable]|![Dark mode support][dark_mode]|

[hex_input]: ./Documentation/hex_input.gif "New Hex input field"
[minimum_config]: ./Documentation/demo_minimum_configuration.png "Color picker supporting RGB, HSB, and Grayscale"
[fully_configurable]: ./Documentation/demo_customizable.png "Fully configurable"
[dark_mode]: ./Documentation/demo_dark_mode.png "Dark mode support"

## Example
To get a quick overview, you can checkout the example app on [Appetize.io](https://appetize.io/embed/gggkv26ep4xn6819f181ffqxpw?device=iphonex&scale=75&autoplay=false&orientation=portrait&deviceColor=black)

To run the example project from Xcode, clone the repo, and run `pod install` from the Example directory first.

## Installation

There are currently four different ways to integrate **SheetyColors** into your apps.

### CocoaPods

```ruby
use_frameworks!

target 'MyApp' do
  pod 'SheetyColors'
end
```

### Swift Package Manager

```ruby
dependencies: [
    .package(url: "https://github.com/chrs1885/SheetyColors.git", from: "1.2.0")
]
```

### Carthage

```ruby
github "chrs1885/SheetyColors"
```

### Manually

Simply drop `SheetyColors.xcodeproj` into your project. Also make sure to add
`SheetyColors.framework` to your app’s embedded frameworks found in the General tab of your main project.

## Usage

Creating a SheetyColors picker is as easy as creating a normal `.actionSheet` styled `UIAlertController`. First, you need to import the library:

```swift
import SheetyColors
```

Next, simply create a `SheetyColorsController` instance and add some actions to it:

```swift

// Create a SheetyColors view with your configuration
let config = SheetyColorsConfig(alphaEnabled: true, initialColor: color, hapticFeedbackEnabled: true, title: "Create a color", type: .rgb)
let sheetyColors = SheetyColorsController(withConfig: config)

// Add a button to accept the selected color
let selectAction = UIAlertAction(title: "Save Color", style: .default, handler: { _ in
	self.color = sheetyColors.color
}
sheetyColors.addAction(selectAction)

// Add a cancel button
let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
sheetyColors.addAction(cancelAction)

// Now, present it to the user
present(sheetyColors, animated: true, completion: nil)
        
```

Please check the [documentation](./Documentation/Reference/README.md) for further information on the API.

### Custom container views
If you prefer to use the color picker inside a custom view controller, you can do so by creating the picker's view controller directly:

```swift
return SheetyColorsViewFactory.createView(withConfig: config, delegate: myDelegate)

```

The class of the `myDelegate` instance needs to conform to the `SheetyColorsDelegate`:

```swift
class MyViewController: SheetyColorsDelegate {

	...
	
	func didSelectColor(_ color: UIColor) {
	    self.color = color
	}
}
```

`didSelectColor` will be called on any slider change.

### SwiftUI support
With SwiftUI projects the color picker can't be used inside the action sheet that Apple provides. However, you can embed the view inside your custom view container by using the `SheetyColorsView`:

```swift
struct ContentView: View {
	@State var selectedColor: UIColor = UIColor.white
	let config = SheetyColorsConfig(alphaEnabled: true, hapticFeedbackEnabled: true, initialColor: UIColor.red, type: .rgb)

	var body: some View {
		Text("Select a color")
			.foregroundColor(Color(self.$selectedColor.wrappedValue))
		SheetyColorsView(config: config, color: self.$selectedColor)
	}
}
```

[Here's an example](https://gist.github.com/chrs1885/d3b9310f92a247b1ad6e022896596401) of how creating an action sheet styled color picker with SwiftUI and SheetyColors.

## Contributions

We'd love to see you contributing to this project by proposing or adding features, reporting bugs, or spreading the word. Please have a quick look at our [contribution guidelines](./.github/CONTRIBUTING.md).

## License

SheetyColors is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
