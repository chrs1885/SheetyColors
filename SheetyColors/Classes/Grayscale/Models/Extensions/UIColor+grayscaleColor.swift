//
//  UIColor+grayscaleColor.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 25.04.19.
//

import Capable
import UIKit

/// Extends UIColor with functionality to convert an instance to a GrayscaleColor.
public extension UIColor {
    /// The GrayscaleColor representation of the UIColor instance.
    var grayscaleColor: GrayscaleColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0

        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            red.constrainTo(max: 1.0)
            green.constrainTo(max: 1.0)
            blue.constrainTo(max: 1.0)
            var luminocity: CGFloat = 0.2126 * red + 0.7152 * green + 0.0722 * blue
            luminocity.normalizeTo(max: 255.0)
            alpha.normalizeTo(max: 100.0)

            return GrayscaleColor(white: luminocity, alpha: alpha)
        } else {
            return GrayscaleColor(white: 0.0, alpha: 100.0)
        }
    }
}
