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
     
     - Returns: A SheetyColorsViewController instance.
     */
    static func createView(withConfig config: SheetyColorsConfigProtocol) -> SheetyColorsViewController {
        var viewModel: SheetyColorsViewModelProtocol
        let hasTextOrMessage: Bool = config.title != nil || config.message != nil

        switch config.type {
        case .grayscale:
            viewModel = GrayscaleViewModel(withColorModel: config.initialColor.grayscaleColor, isAlphaEnabled: config.alphaEnabled, hasTextOrMessage: hasTextOrMessage)
        case .hsb:
            viewModel = HSBViewModel(withColorModel: config.initialColor.hsbaColor, isAlphaEnabled: config.alphaEnabled, hasTextOrMessage: hasTextOrMessage)
        case .rgb:
            viewModel = RGBViewModel(withColorModel: config.initialColor.rgbaColor, isAlphaEnabled: config.alphaEnabled, hasTextOrMessage: hasTextOrMessage)
        }

        let viewController = SheetyColorsViewController.create()
        viewController.viewModel = viewModel
        viewController.hapticFeedbackEnabled = config.hapticFeedbackEnabled
        viewModel.viewModelDelegate = viewController

        return viewController
    }
}
