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
        static let keyContentViewController = "contentViewController"
    }

    /// The current color managed by the SheetyColorsController instance.
    var color: UIColor {
        guard let controller = value(forKey: Constants.keyContentViewController) as? SheetyColorsViewController else { fatalError() }

        return controller.previewColor
    }

    /**
     Creates a SheetyColorsController instance.

     - Parameter:
         - config: A config object containing options for specifying the look and feel of a SheetyColors view.
     */
    convenience init(withConfig config: SheetyColorsConfigProtocol) {
        self.init(title: config.title, message: nil, preferredStyle: .actionSheet)

        let controller = SheetyColorsViewFactory.createView(withConfig: config)
        setValue(controller, forKey: Constants.keyContentViewController)
    }
}
