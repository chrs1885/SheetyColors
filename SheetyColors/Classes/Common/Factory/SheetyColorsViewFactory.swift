//
//  SheetyColorsViewFactory.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.02.19.
//

import UIKit

/// A factory for creating SheetyColors view controller
public struct SheetyColorsViewFactory {
    /**
     Creates a SheetyColorsViewController instance based on a given configuration.

     - Parameter:
     - config: Defines all aspects of the view such as a color model type, alpha value support, texts, initial colors, or haptical feedback.
     - delegate: A delegate used for handling the color selection. A delegate needs to be provided in cases where you want to use the SheetyColorsViewController directly and not as part of a UIAlertViewController (e.g. SwiftUI).

     - Returns: A SheetyColorsViewController instance.
     */
    public static func createView(withConfig config: SheetyColorsConfigProtocol, delegate: SheetyColorsDelegate? = nil) -> SheetyColorsViewController {
        var viewModel: SheetyColorsViewModelProtocol

        switch config.type {
        case .grayscale:
            viewModel = GrayscaleViewModel(withConfig: config)
        case .hsb:
            viewModel = HSBViewModel(withConfig: config)
        case .rgb:
            viewModel = RGBViewModel(withConfig: config)
        }

        let viewController = SheetyColorsViewController(viewModel: viewModel)
        viewModel.viewDelegate = viewController
        viewModel.delegate = delegate

        return viewController
    }
}
