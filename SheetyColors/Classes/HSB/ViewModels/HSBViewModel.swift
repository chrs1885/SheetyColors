//
//  HSBViewModel.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 20.04.19.
//

private enum SliderType: Int, CaseIterable {
    case hue, saturation, brightness, alpha
}

class HSBViewModel {
    var isAlphaEnabled: Bool
    var colorModel: HSBAColor
    var appearenceProvider: AppearenceProviderProtocol = AppearenceProvider()
    weak var viewModelDelegate: SheetyColorsViewModelDelegate?

    lazy var appearence: Appearence = {
        return self.appearenceProvider.current
    }()

    init(withColorModel colorModel: HSBAColor, alphaEnabled: Bool) {
        self.colorModel = colorModel
        isAlphaEnabled = alphaEnabled
    }
}

extension HSBViewModel: SheetyColorsViewModelProtocol {
    var primaryKeyText: String {
        return "HSB"
    }

    var primaryValueText: String {
        return "\(Int(colorModel.hue)) \(Int(colorModel.saturation)) \(Int(colorModel.brightness)) \(Int(colorModel.alpha))%"
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

    func rainbowEnabled(forSliderAt index: Int) -> Bool {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        return slider == .hue
    }

    func stepInterval(forSliderAt _: Int) -> CGFloat {
        return 1.0
    }

    func value(forSliderAt index: Int) -> CGFloat {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .hue:
            return colorModel.hue
        case .saturation:
            return colorModel.saturation
        case .brightness:
            return colorModel.brightness
        case .alpha:
            return colorModel.alpha
        }
    }

    func maximumValue(forSliderAt index: Int) -> CGFloat {
        guard let slider = SliderType(rawValue: index) else { fatalError() }
        let maxValue: CGFloat = (slider == .hue) ? 360.0 : 100.0

        return maxValue
    }

    func minimumColorModel(forSliderAt index: Int) -> SheetyColorProtocol {
        guard let slider = SliderType(rawValue: index) else { fatalError() }
        if case .alpha = slider {
            let brightness: CGFloat = appearence == .light ? 100.0 : 0.0
            return HSBAColor(hue: 360.0, saturation: 0.0, brightness: brightness, alpha: 100.0)
        }

        guard let color = colorModel.copy() as? HSBAColor else { fatalError() }

        switch slider {
        case .hue:
            color.hue = 0.0
        case .saturation:
            color.saturation = 0.0
        case .brightness:
            color.brightness = 0.0
        default: ()
        }
        color.alpha = 100.0

        return color
    }

    func maximumColorModel(forSliderAt index: Int) -> SheetyColorProtocol {
        guard let slider = SliderType(rawValue: index), let color = colorModel.copy() as? HSBAColor else {
            fatalError()
        }

        switch slider {
        case .hue:
            color.hue = 360.0
        case .saturation:
            color.saturation = 100.0
        case .brightness:
            color.brightness = 100.0
        default: ()
        }
        color.alpha = 100.0

        return color
    }

    func thumbText(forSliderAt index: Int) -> String? {
        guard let slider = SliderType(rawValue: index) else { fatalError() }

        switch slider {
        case .hue:
            return "H"
        case .saturation:
            return "S"
        case .brightness:
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
        case .hue:
            colorModel.hue = floor(value)
        case .saturation:
            colorModel.saturation = floor(value)
        case .brightness:
            colorModel.brightness = floor(value)
        case .alpha:
            colorModel.alpha = floor(value)
        }

        viewModelDelegate?.didUpdateColorComponent(in: self)
    }
}
