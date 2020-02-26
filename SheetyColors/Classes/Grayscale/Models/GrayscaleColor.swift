//
//  GrayscaleColor.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 25.04.19.
//

import UIKit

/// A model class representing grayscale colors. The white component can hold values between 0.0 and 255.0 while the alphavalue has a maximum value of 100.0.
public class GrayscaleColor: NSObject, NSCopying, Codable {
    var white, alpha: CGFloat

    var hexColor: String {
        let rgb: Int = Int(white) << 16 | Int(white) << 8 | Int(white) << 0

        return String(format: "%06x", rgb).uppercased()
    }

    /**
     Creates a GrayscaleColor instance.

     - Parameter:
     - white: The white component.
     - alpha: The opacity component.
     */
    public init(white: CGFloat, alpha: CGFloat) {
        self.white = white
        self.alpha = alpha
    }

    /**
     Creates a copy of the GrayscaleColor instance.

     - Returns: A copy of the GrayscaleColor instance.
     */
    public func copy(with _: NSZone? = nil) -> Any {
        let copy = GrayscaleColor(white: white, alpha: alpha)
        return copy
    }

    /**
     Compares two GrayscaleColor instances with each other.

     - Parameter object: The GrayscaleColor to compare with.

     - Returns: 'true' if the instance is equal to the other GrayscaleColor instance, otherwise 'false''.
     */
    public override func isEqual(_ object: Any?) -> Bool {
        guard let otherColor = object as? GrayscaleColor else {
            return false
        }

        return white == otherColor.white && alpha == otherColor.alpha
    }
}

// MARK: - Converting to other color models

/// An extension adding functionality defined in SheetyColorProtocol to GrayscaleColor.
extension GrayscaleColor: SheetyColorProtocol {
    /// The UIColor representation of the GrayscaleColor.
    public var uiColor: UIColor {
        return UIColor(white: white / 255.0, alpha: alpha / 100.0)
    }
}
