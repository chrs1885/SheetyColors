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
        let hasTextOrMessage: Bool = config.title != nil || config.message != nil

        switch config.type {
        case .grayscale:
            viewModel = GrayscaleViewModel(withColorModel: config.initialColor.grayscaleColor, isAlphaEnabled: config.alphaEnabled, hasTextOrMessage: hasTextOrMessage)
        case .hsb:
            viewModel = HSBViewModel(withColorModel: config.initialColor.hsbaColor, isAlphaEnabled: config.alphaEnabled, hasTextOrMessage: hasTextOrMessage)
        case .rgb:
            viewModel = RGBViewModel(withColorModel: config.initialColor.rgbaColor, isAlphaEnabled: config.alphaEnabled, hasTextOrMessage: hasTextOrMessage)
        }

        let view = SheetyColorsViewController.create()
        view.viewModel = viewModel
        view.hapticFeedbackEnabled = config.hapticFeedbackEnabled
        viewModel.viewModelDelegate = view

        return view
    }
}
