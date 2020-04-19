//
//  HSBAColor.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 20.04.19.
//

import UIKit

/// A model class representing HSBA colors. The hue component can hold values between 0.0 and 360.0 while the saturation and brightnes values have a maximum value of 100.0.
public class HSBAColor: NSObject, NSCopying, Codable {
    var hue, saturation, brightness, alpha: CGFloat

    var hexColor: String {
        if let colorRef = uiColor.cgColor.components {
            let red: CGFloat = colorRef[0]
            let green: CGFloat = colorRef[1]
            let blue: CGFloat = colorRef[2]

            return String(format: "%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255))).uppercased()
        }

        return ""
    }

    /**
     Creates a HSBAColor instance.

     - Parameter:
     - hue: The hue component.
     - saturation: The saturation component.
     - brightness: The brightness component.
     - alpha: The opacity component.
     */
    public init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.alpha = alpha
    }

    /**
     Creates a copy of the HSBAColor instance.

     - Returns: A copy of the HSBAColor instance.
     */
    public func copy(with _: NSZone? = nil) -> Any {
        let copy = HSBAColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        return copy
    }

    /**
     Compares two HSBAColor instances with each other.

     - Parameter object: The HSBAColor to compare with.

     - Returns: 'true' if the instance is equal to the other HSBAColor instance, otherwise 'false''.
     */
    public override func isEqual(_ object: Any?) -> Bool {
        guard let otherColor = object as? HSBAColor else {
            return false
        }

        return hue == otherColor.hue &&
            saturation == otherColor.saturation &&
            brightness == otherColor.brightness &&
            alpha == otherColor.alpha
    }
}

// MARK: - Converting to other color models

/// An extension adding functionality defined in SheetyColorProtocol to HSBAColor.
extension HSBAColor: SheetyColorProtocol {
    /// The UIColor representation of the HSBAColor.
    public var uiColor: UIColor {
        return UIColor(hue: hue / 360.0, saturation: saturation / 100.0, brightness: brightness / 100.0, alpha: alpha / 100.0)
    }
}
