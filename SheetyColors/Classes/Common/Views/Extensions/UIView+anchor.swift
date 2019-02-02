//
//  UIView+anchor.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 17.02.19.
//

import UIKit

extension UIView {
    func anchor(
        top: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat = 0.0,
        bottom: NSLayoutYAxisAnchor? = nil, paddingBottom: CGFloat = 0.0,
        left: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat = 0.0,
        right: NSLayoutXAxisAnchor? = nil, paddingRight: CGFloat = 0.0,
        width: NSLayoutDimension? = nil, widthConstant: CGFloat = 0.0,
        height: NSLayoutDimension? = nil, heightConstant: CGFloat = 0.0
    ) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }

        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }

        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalTo: width, constant: widthConstant).isActive = true
        } else if widthConstant != 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalTo: height, constant: heightConstant).isActive = true
        } else if heightConstant != 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
}
