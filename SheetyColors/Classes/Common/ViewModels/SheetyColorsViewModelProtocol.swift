//
//  SheetyColorsViewModelProtocol.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 08.02.19.
//

import CoreGraphics
protocol SheetyColorsViewModelProtocol {
    var viewModelDelegate: SheetyColorsViewModelDelegate? { get set }
    var hasTextOrMessage: Bool { get }
    var primaryKeyText: String { get }
    var primaryValueText: String { get }
    var secondaryKeyText: String { get }
    var secondaryValueText: String { get }
    var previewColorModel: SheetyColorProtocol { get }
    var numberOfSliders: Int { get }

    func rainbowEnabled(forSliderAt index: Int) -> Bool
    func stepInterval(forSliderAt index: Int) -> CGFloat
    func value(forSliderAt index: Int) -> CGFloat
    func maximumValue(forSliderAt index: Int) -> CGFloat
    func minimumColorModel(forSliderAt index: Int) -> SheetyColorProtocol
    func maximumColorModel(forSliderAt index: Int) -> SheetyColorProtocol
    func thumbText(forSliderAt index: Int) -> String?
    func thumbIconName(forSliderAt index: Int) -> String?
    func sliderValueChanged(forSliderAt index: Int, value: CGFloat)
}
