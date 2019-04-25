//
//  UIColor+grayscaleColor.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 25.04.19.
//

import UIKit

/// Extends UIColor with functionality to convert an instance to a GrayscaleColor.
public extension UIColor {
    
    /// The GrayscaleColor representation of the UIColor instance.
    var grayscaleColor: GrayscaleColor {
        func normalize(_ component: CGFloat, multiplier: CGFloat) -> CGFloat {
            let nomralizedValue = floor(component * multiplier)
            
            if nomralizedValue > multiplier { return multiplier }
            if nomralizedValue < 0.0 { return 0.0 }
            return nomralizedValue
        }
        
        var white: CGFloat = 0, alpha: CGFloat = 0
        
        if getWhite(&white, alpha: &alpha) {
            let white = normalize(white, multiplier: 255.0)
            let alpha = normalize(alpha, multiplier: 100.0)
            
            return GrayscaleColor(white: white, alpha: alpha)
        } else {
            return GrayscaleColor(white: 0.0, alpha: 100.0)
        }
    }
}

