//
//  SheetyColorsConfigMock.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 25.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SheetyColors

struct SheetyColorsConfigMock: SheetyColorsConfigProtocol {
    var alphaEnabled: Bool
    var initialColor: UIColor
    var hapticFeedbackEnabled: Bool
    var title: String
    var type: SheetyColorsType
}
