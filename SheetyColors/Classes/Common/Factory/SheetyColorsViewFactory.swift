//
//  SheetyColorsViewFactory.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.02.19.
//

import UIKit

struct SheetyColorsViewFactory {
    static func createView(withConfig config: SheetyColorsConfigProtocol) -> SheetyColorsViewController {
        var viewModel: SheetyColorsViewModelProtocol

        switch config.type {
        case .grayscale:
            viewModel = GrayscaleViewModel(withColorModel: config.initialColor.grayscaleColor, alphaEnabled: config.alphaEnabled)
        case .hsb:
            viewModel = HSBViewModel(withColorModel: config.initialColor.hsbaColor, alphaEnabled: config.alphaEnabled)
        case .rgb:
            viewModel = RGBViewModel(withColorModel: config.initialColor.rgbaColor, alphaEnabled: config.alphaEnabled)
        }

        let view = SheetyColorsViewController.create()
        view.viewModel = viewModel
        view.hapticFeedbackEnabled = config.hapticFeedbackEnabled
        viewModel.viewModelDelegate = view

        return view
    }
}
