//
//  SheetyColorsDelegate.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 14.03.20.
//

import UIKit

/// A protocol defining functions that are called when interacting with a color picker.
public protocol SheetyColorsDelegate: AnyObject {
    /**
     A delegate function that gets called once any slider value has been changed.

     - Parameter:
     - color: The updated color.
     */
    func didSelectColor(_ color: UIColor)
}
