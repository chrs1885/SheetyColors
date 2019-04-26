//
//  CGFloat+constrainToRange.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 25.04.19.
//

import Foundation

extension CGFloat {
    mutating func constrainTo(min: CGFloat = 0.0, max: CGFloat) {
        if self > max {
            self = max
        } else if self < min {
            self = min
        }
    }

    mutating func normalizeTo(max: CGFloat) {
        self *= max
        constrainTo(max: max)
        round(.down)
    }
}
