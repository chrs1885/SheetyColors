//
//  SheetyColorsDelegateMock.swift
//  SheetyColors_Tests
//
//  Created by Wendt, Christoph on 29.03.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import SheetyColors

class SheetyColorsDelegateMock: SheetyColorsDelegate {
    var didCallDidSelectColor = false
    var selectedColor: UIColor?

    func didSelectColor(_ color: UIColor) {
        didCallDidSelectColor = true
        selectedColor = color
    }
}
