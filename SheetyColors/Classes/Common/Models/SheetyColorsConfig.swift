//
//  SheetyColorsConfig.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.02.19.
//

import UIKit

/// A struct defining options for configuring a SheetyColors view.
public struct SheetyColorsConfig: SheetyColorsConfigProtocol {
    /// Defines whether an opacity slider should be displayed or not. Defaults to `true`.
    public var alphaEnabled: Bool

    /// Defines whether haptic feedback is supported when changing a slider's value. Defaults to `true`.
    public var hapticFeedbackEnabled: Bool

    /// The initial color used when displaying the SheetyColors view. Defaults to `.white`.
    public var initialColor: UIColor

    /// A title text displayed inside the SheetyColors view. Defaults to an empty string.
    public var title: String

    /// The color model used by the SheetyColors view. Defaults to `.rgb`.
    public var type: SheetyColorsType

    /**
     Creates a SheetyColorsConfig instance.

     - Parameter:
     - red: The red component.
     - green: The green component.
     - blue: The blue component.
     - alpha: The opacity component.
     */
    public init(alphaEnabled: Bool = true, hapticFeedbackEnabled: Bool = true, initialColor: UIColor = .white, title: String = "", type: SheetyColorsType = .rgb) {
        self.alphaEnabled = alphaEnabled
        self.hapticFeedbackEnabled = hapticFeedbackEnabled
        self.initialColor = initialColor
        self.title = title
        self.type = type
    }
}
