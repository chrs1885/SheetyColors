//
//  RGBAColor.swift
//  Capable
//
//  Created by Christoph Wendt on 10.02.19.
//

import UIKit

/// A model class representing RGBA colors. The red, green, and blue component can hold values between 0.0 and 255.0 while the alpha value has a maximum value of 100.0.
public class RGBAColor: NSObject, NSCopying, Codable {
    var red, green, blue, alpha: CGFloat

    var hexColor: String {
        let rgb: Int = Int(red) << 16 | Int(green) << 8 | Int(blue) << 0

        return String(format: "%06x", rgb).uppercased()
    }

    /**
     Creates a RGBAColor instance.

     - Parameter:
     - red: The red component.
     - green: The green component.
     - blue: The blue component.
     - alpha: The opacity component.
     */
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    /**
     Creates a copy of the RGBAColor instance.

     - Returns: A copy of the RGBAColor instance.
     */
    public func copy(with _: NSZone? = nil) -> Any {
        let copy = RGBAColor(red: red, green: green, blue: blue, alpha: alpha)
        return copy
    }

    /**
     Compares two RGBAColor instances with each other.

     - Parameter object: The RGBAColor to compare with.

     - Returns: 'true' if the instance is equal to the other RGBAColor instance, otherwise 'false''.
     */
    public override func isEqual(_ object: Any?) -> Bool {
        guard let otherColor = object as? RGBAColor else {
            return false
        }

        return red == otherColor.red &&
            green == otherColor.green &&
            blue == otherColor.blue &&
            alpha == otherColor.alpha
    }
}

// MARK: - Converting to other color models

/// An extension adding functionality defined in SheetyColorProtocol to RGBAColor.
extension RGBAColor: SheetyColorProtocol {
    /// The UIColor representation of the RGBAColor.
    public var uiColor: UIColor {
        return UIColor(red: red / 255.0,
                       green: green / 255.0,
                       blue: blue / 255.0,
                       alpha: alpha / 100.0)
    }
}
