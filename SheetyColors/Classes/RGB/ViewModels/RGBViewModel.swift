//
//  RGBViewModel.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.02.19.
//

import CoreGraphics
import UIKit

private enum SliderType: Int, CaseIterable {
    case red, green, blue, alpha
}

class RGBViewModel {
    let isHapticFeedbackEnabled: Bool
    let hasTextOrMessage: Bool
    let isAlphaEnabled: Bool
    var colorModel: RGBAColor
    var appearenceProvider: AppearenceProviderProtocol = AppearenceProvider()
    weak var viewDelegate: SheetyColorsViewDelegate?
    weak var delegate: SheetyColorsDelegate?

    lazy var appearence: Appearence = {
        self.appearenceProvider.current
    }()

    init(withConfig config: SheetyColorsConfigProtocol) {
        colorModel = config.initialColor.rgbaColor
        hasTextOrMessage = config.title != nil || config.message != nil
        isAlphaEnabled = config.alphaEnabled
        isHapticFeedbackEnabled = config.hapticFeedbackEnabled
    }
}

extension RGBViewModel: SheetyColorsViewModelProtocol {
    var primaryKeyText: String {
        return "RGB"
    }

    var primaryValueText: String {
        return "\(Int(colorModel.red)) \(Int(colorModel.green)) \(Int(colorModel.blue)) \(Int(colorModel.alpha))%"
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
        return isAlphaEnabled ? 4 : 3
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
        case .red:
            return colorModel.red
        case .green:
            return colorModel.green
        case .blue:
            return colorModel.blue
        case .alpha:
            return colorModel.alpha
        }
    }

    func maximumValue(forSliderAt index: Int) -> CGFloat {
        guard let slider = SliderType(rawValue: index) else { fatalError() }
        let maxValue: CGFloat = (slider == .alpha) ? 100.0 : 255.0

        return maxValue
    }

    func minimumColorModel(forSliderAt index: Int) -> SheetyColorProtocol {
        guard let slider = SliderType(rawValue: index) else { fatalError() }
        if case .alpha = slider {
            let value: CGFloat = appearence == .light ? 255.0 : 0.0
            return RGBAColor(red: value, green: value, blue: value, alpha: 100.0)
        }

        guard let color = colorModel.copy() as? RGBAColor else { fatalError() }

        switch slider {
        case .red:
            color.red = 0.0
        case .green:
            color.green = 0.0
        case .blue:
            color.blue = 0.0
        default: ()
        }
        color.alpha = 100.0

        return color
    }

    func maximumColorModel(forSliderAt index: Int) -> SheetyColorProtocol {
        guard let slider = SliderType(rawValue: index), let color = colorModel.copy() as? RGBAColor else {
            fatalError()
        }

        switch slider {
        case .red:
            color.red = 255.0
        case .green:
            color.green = 255.0
        case .blue:
            color.blue = 255.0
        default: ()
        }
        color.alpha = 100.0

        return color
    }

    func thumbText(forSliderAt index: Int) -> String? {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .red:
            return "R"
        case .green:
            return "G"
        case .blue:
            return "B"
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
        case .red:
            colorModel.red = floor(value)
        case .green:
            colorModel.green = floor(value)
        case .blue:
            colorModel.blue = floor(value)
        case .alpha:
            colorModel.alpha = floor(value)
        }

        viewDelegate?.didUpdateColorComponent(in: self, shouldAnimate: false)
        delegate?.didSelectColor(colorModel.uiColor)
    }

    func hexValueChanged(to value: String) {
        guard let color = UIColor(hex: value) else { return }
        
        colorModel = color.rgbaColor
        viewDelegate?.didUpdateColorComponent(in: self, shouldAnimate: true)
        delegate?.didSelectColor(colorModel.uiColor)
    }
}
