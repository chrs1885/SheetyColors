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
        func normalize(_ component: CGFloat, multiplier: CGFloat) -> CGFloat {
            let nomralizedValue = floor(component * multiplier)

            if nomralizedValue > multiplier { return multiplier }
            if nomralizedValue < 0.0 { return 0.0 }
            return nomralizedValue
        }

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0

        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let red = normalize(red, multiplier: 255.0)
            let green = normalize(green, multiplier: 255.0)
            let blue = normalize(blue, multiplier: 255.0)
            let alpha = normalize(alpha, multiplier: 100.0)

            return RGBAColor(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return RGBAColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        }
    }
}
