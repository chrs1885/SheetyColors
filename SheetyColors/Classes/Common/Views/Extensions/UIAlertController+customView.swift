//
//  UIAlertController+customView.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 02.02.19.
//

import UIKit

/// A typealias of UIAlertController used when creating SheetyColors views.
public typealias SheetyColorsController = UIAlertController

/// An extension defining properties and functions used when managing SheetyColorsController instances.
public extension SheetyColorsController {
    private struct Constants {
        static let sheetyColorsViewTag = 1885
        static let marker = "SHEETY_COLORS_VIEW"
    }

    /// The current color managed by the SheetyColorsController instance.
    var color: UIColor {
        guard let view = view.viewWithTag(Constants.sheetyColorsViewTag) as? SheetyColorsView else {
            fatalError()
        }

        return view.previewColor
    }

    /**
     Creates a SheetyColorsController instance.

     - Parameter:
         - config: A config object containing options for specifying the look and feel of a SheetyColors view.
     */
    convenience init(withConfig config: SheetyColorsConfigProtocol) {
        let sheetyColorsView = SheetyColorsViewFactory.createView(withConfig: config)

        self.init(title: config.title, message: Constants.marker, preferredStyle: .actionSheet)
        if let placeholderView = view.findLabel(withText: Constants.marker),
            let containerView = placeholderView.superview {
            sheetyColorsView.tag = Constants.sheetyColorsViewTag
            containerView.addSubview(sheetyColorsView)

            sheetyColorsView.translatesAutoresizingMaskIntoConstraints = false
            sheetyColorsView.anchor(top: placeholderView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, height: placeholderView.heightAnchor)
            placeholderView.text = ""
        }
    }
}
