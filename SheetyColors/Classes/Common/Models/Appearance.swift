//
//  Appearance.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 04.08.19.
//

import UIKit

enum Appearance {
    case light, dark, unknown

    static var current: Appearance {
        let checkColor = UIColor(named: "AppearanceCeckColor", in: Bundle.framework, compatibleWith: nil)

        if checkColor?.grayscaleColor.white == 255.0 {
            return .light
        } else {
            return .dark
        }
    }
}
