//
//  UIColor+hsbaColor.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 20.04.19.
//

import UIKit

/// Extends UIColor with functionality to convert an instance to a HSBAColor.
public extension UIColor {
    /// The HSBAColor representation of the UIColor instance.
    var hsbaColor: HSBAColor {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0

        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            hue.normalizeTo(max: 360.0)
            saturation.normalizeTo(max: 100.0)
            brightness.normalizeTo(max: 100.0)
            alpha.normalizeTo(max: 100.0)

            return HSBAColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        } else {
            return HSBAColor(hue: 0.0, saturation: 100.0, brightness: 100.0, alpha: 100.0)
        }
    }
}
