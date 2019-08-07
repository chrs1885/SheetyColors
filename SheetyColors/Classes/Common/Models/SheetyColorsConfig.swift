//
//  SheetyColorsConfig.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.02.19.
//

import UIKit

/// A struct defining options for configuring a SheetyColors view.
public struct SheetyColorsConfig: SheetyColorsConfigProtocol {
    /// Defines whether an opacity slider should be displayed or not.
    public var alphaEnabled: Bool

    /// Defines whether haptic feedback is supported when changing a slider's value.
    public var hapticFeedbackEnabled: Bool

    /// The initial color used when displaying the SheetyColors view.
    public var initialColor: UIColor

    /// A description text displayed inside the SheetyColors view.
    public var message: String?

    /// A title text displayed inside the SheetyColors view.
    public var title: String?

    /// The color model used by the SheetyColors view.
    public var type: SheetyColorsType

    /**
     Creates a SheetyColorsConfig instance.

     - Parameter:
     - alphaEnabled: Defines whether an opacity slider should be displayed or not. Defaults to `true`.
     - hapticFeedbackEnabled: Defines whether haptic feedback is supported when changing a slider's value. Defaults to `true`.
     - initialColor: The initial color used when displaying the SheetyColors view. Defaults to `.white`.
     - title: A title text displayed inside the SheetyColors view. Defaults to `nil`.
     - message: A description text displayed inside the SheetyColors view. Defaults to `nil`.
     - type: The color model used by the SheetyColors view. Defaults to `.rgb`.
     */
    public init(alphaEnabled: Bool = true, hapticFeedbackEnabled: Bool = true, initialColor: UIColor = .white, title: String? = nil, message: String? = nil, type: SheetyColorsType = .rgb) {
        self.alphaEnabled = alphaEnabled
        self.hapticFeedbackEnabled = hapticFeedbackEnabled
        self.initialColor = initialColor
        self.message = message
        self.title = title
        self.type = type
    }
}
