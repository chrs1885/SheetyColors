//
//  GrayscaleViewModel.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 25.04.19.
//

private enum SliderType: Int, CaseIterable {
    case white, alpha
}

class GrayscaleViewModel {
    var isAlphaEnabled: Bool
    var colorModel: GrayscaleColor
    weak var viewModelDelegate: SheetyColorsViewModelDelegate?

    init(withColorModel colorModel: GrayscaleColor, alphaEnabled: Bool) {
        self.colorModel = colorModel
        isAlphaEnabled = alphaEnabled
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
            return GrayscaleColor(white: 255.0, alpha: 100.0)
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

        viewModelDelegate?.didUpdateColorComponent(in: self)
    }
}
