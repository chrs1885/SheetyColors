//
//  SheetyColorsConfigProtocol.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 03.02.19.
//

import UIKit

/// A protocol defining all options that can be used for configuring a SheetyColors view.
public protocol SheetyColorsConfigProtocol {
    /// Defines whether an opacity slider should be displayed or not.
    var alphaEnabled: Bool { get }

    /// Defines the border color of the preview color field.
    var previewBorderColor: UIColor { get }
    
    /// Defines whether haptic feedback is supported when changing a slider's value.
    var hapticFeedbackEnabled: Bool { get }

    /// The initial color used when displaying the SheetyColors view.
    var initialColor: UIColor { get }

    /// A description text displayed inside the SheetyColors view.
    var message: String? { get }

    /// A title text displayed inside the SheetyColors view.
    var title: String? { get }

    /// The color model used by the SheetyColors view.
    var type: SheetyColorsType { get }
}
