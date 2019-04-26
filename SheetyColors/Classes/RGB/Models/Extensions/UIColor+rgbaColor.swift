//
//  UIColor+rgbaColor.swift
//  Capable
//
//  Created by Christoph Wendt on 09.02.19.
//

import UIKit

/// Extends UIColor with functionality to convert an instance to a RGBAColor.
public extension UIColor {
    /// The RGBAColor representation of the UIColor instance.
    var rgbaColor: RGBAColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0

        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            red.normalizeTo(max: 255.0)
            green.normalizeTo(max: 255.0)
            blue.normalizeTo(max: 255.0)
            alpha.normalizeTo(max: 100.0)

            return RGBAColor(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return RGBAColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 100.0)
        }
    }
}
