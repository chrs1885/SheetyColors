//
//  GrayscaleViewModel.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 25.04.19.
//

import CoreGraphics
import UIKit

private enum SliderType: Int, CaseIterable {
    case white, alpha
}

class GrayscaleViewModel {
    let isHapticFeedbackEnabled: Bool
    let previewBorderColor: UIColor
    let hasTextOrMessage: Bool
    let isAlphaEnabled: Bool
    var colorModel: GrayscaleColor
    var appearenceProvider: AppearenceProviderProtocol = AppearenceProvider()
    weak var viewDelegate: SheetyColorsViewDelegate?
    weak var delegate: SheetyColorsDelegate?

    lazy var appearence: Appearence = {
        self.appearenceProvider.current
    }()

    init(withConfig config: SheetyColorsConfigProtocol) {
        colorModel = config.initialColor.grayscaleColor
        hasTextOrMessage = config.title != nil || config.message != nil
        isAlphaEnabled = config.alphaEnabled
        isHapticFeedbackEnabled = config.hapticFeedbackEnabled
        previewBorderColor = config.previewBorderColor
    }
}

extension GrayscaleViewModel: SheetyColorsViewModelProtocol {
    var primaryKeyText: String {
        return "Grayscale"
    }

    var primaryValueText: String {
        return "\(Int(colorModel.white)) \(Int(colorModel.alpha))%"
    }

    var secondaryKeyText: String {
        return "HEX"
    }

    var secondaryValueText: String {
        return colorModel.hexColor
    }

    var previewColorModel: SheetyColorProtocol {
        return colorModel
    }

    var numberOfSliders: Int {
        let maxSliderCount = SliderType.allCases.count

        return isAlphaEnabled ? maxSliderCount : maxSliderCount - 1
    }

    func rainbowEnabled(forSliderAt _: Int) -> Bool {
        return false
    }

    func stepInterval(forSliderAt _: Int) -> CGFloat {
        return 1.0
    }

    func value(forSliderAt index: Int) -> CGFloat {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .white:
            return colorModel.white
        case .alpha:
            return colorModel.alpha
        }
    }

    func maximumValue(forSliderAt index: Int) -> CGFloat {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .white:
            return 255.0
        case .alpha:
            return 100.0
        }
    }

    func minimumColorModel(forSliderAt index: Int) -> SheetyColorProtocol {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .white:
            return GrayscaleColor(white: 0.0, alpha: 100.0)
        case .alpha:
            let white: CGFloat = appearence == .light ? 255.0 : 0.0
            return GrayscaleColor(white: white, alpha: 100.0)
        }
    }

    func maximumColorModel(forSliderAt index: Int) -> SheetyColorProtocol {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .white:
            return GrayscaleColor(white: 255.0, alpha: 100.0)
        case .alpha:
            return GrayscaleColor(white: colorModel.white, alpha: 100.0)
        }
    }

    func thumbText(forSliderAt index: Int) -> String? {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .white:
            return "W"
        case .alpha:
            return "%"
        }
    }

    func thumbIconName(forSliderAt _: Int) -> String? {
        return nil
    }

    func sliderValueChanged(forSliderAt index: Int, value: CGFloat) {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .white:
            colorModel.white = floor(value)
        case .alpha:
            colorModel.alpha = floor(value)
        }

        viewDelegate?.didUpdateColorComponent(in: self, shouldAnimate: false)
        delegate?.didSelectColor(colorModel.uiColor)
    }

    func hexValueChanged(to value: String) {
        guard let color = UIColor(hex: value) else { return }
        colorChanged(to: color)
    }
    
    func colorChanged(to color: UIColor) {
        colorModel = color.grayscaleColor
        viewDelegate?.didUpdateColorComponent(in: self, shouldAnimate: true)
        delegate?.didSelectColor(colorModel.uiColor)
    }
}
