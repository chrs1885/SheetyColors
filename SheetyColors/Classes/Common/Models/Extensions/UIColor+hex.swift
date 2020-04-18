//
//  UIColor+hex.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 04.04.20.
//

import Foundation

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b: CGFloat

        let start = hex.index(hex.startIndex, offsetBy: 0)
        let hexColor = String(hex[start...])

        if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000FF) / 255

                self.init(red: r, green: g, blue: b, alpha: 1.0)
                return
            }
        }

        return nil
    }
}
