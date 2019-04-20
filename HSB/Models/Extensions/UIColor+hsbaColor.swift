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
        func normalize(_ component: CGFloat, multiplier: CGFloat) -> CGFloat {
            let nomralizedValue = component * multiplier

            if nomralizedValue > multiplier { return multiplier }
            if nomralizedValue < 0.0 { return 0.0 }
            return nomralizedValue
        }

        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0

        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let hue = normalize(hue, multiplier: 360.0)
            let saturation = normalize(saturation, multiplier: 100.0)
            let brightness = normalize(brightness, multiplier: 100.0)
            let alpha = normalize(alpha, multiplier: 100.0)

            return HSBAColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        } else {
            return HSBAColor(hue: 0.0, saturation: 100.0, brightness: 100.0, alpha: 1)
        }
    }
}
