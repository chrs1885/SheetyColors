//
//  SheetyColorsViewFactory.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.02.19.
//

import UIKit

struct SheetyColorsViewFactory {
    static func createView(withConfig config: SheetyColorsConfigProtocol) -> SheetyColorsView {
        var viewModel: SheetyColorsViewModelProtocol

        switch config.type {
        case .rgb:
            viewModel = RGBViewModel(withColorModel: config.initialColor.rgbaColor, alphaEnabled: config.alphaEnabled)
        case .hsb:
            viewModel = HSBViewModel(withColorModel: config.initialColor.hsbaColor, alphaEnabled: config.alphaEnabled)
        }

        let view = SheetyColorsView(withViewModel: viewModel, hapticFeedbackEnabled: config.hapticFeedbackEnabled)
        viewModel.viewModelDelegate = view

        return view
    }
}
