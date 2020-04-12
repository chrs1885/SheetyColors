//
//  SheetyColorsViewModelMock.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 29.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
@testable import SheetyColors

class SheetyColorsViewModelMock: SheetyColorsViewModelProtocol {
    weak var delegate: SheetyColorsDelegate?
    weak var viewDelegate: SheetyColorsViewDelegate?
    var primaryKeyText: String = ""
    var primaryValueText: String = ""
    var secondaryKeyText: String = ""
    var secondaryValueText: String = ""
    var hasTextOrMessage: Bool = false
    var isHapticFeedbackEnabled: Bool = false
    var previewColorModel: SheetyColorProtocol = RGBAColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    var numberOfSliders: Int = 0

    func rainbowEnabled(forSliderAt _: Int) -> Bool {
        return false
    }

    func stepInterval(forSliderAt _: Int) -> CGFloat {
        return 0.0
    }

    func value(forSliderAt _: Int) -> CGFloat {
        return 0.0
    }

    func maximumValue(forSliderAt _: Int) -> CGFloat {
        return 0.0
    }

    func minimumColorModel(forSliderAt _: Int) -> SheetyColorProtocol {
        return RGBAColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    }

    func maximumColorModel(forSliderAt _: Int) -> SheetyColorProtocol {
        return RGBAColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    }

    func thumbText(forSliderAt _: Int) -> String? {
        return nil
    }

    func thumbIconName(forSliderAt _: Int) -> String? {
        return nil
    }

    func sliderValueChanged(forSliderAt _: Int, value _: CGFloat) {}
    
    func hexValueChanged(withColor color: UIColor) {}
}
