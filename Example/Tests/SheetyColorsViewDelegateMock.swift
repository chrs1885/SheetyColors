//
//  SheetyColorsViewModelDelegateMock.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 29.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
@testable import SheetyColors

class SheetyColorsViewDelegateMock: SheetyColorsViewDelegate {
    var didCallDidUpdateColorComponent = false

    func didUpdateColorComponent(in _: SheetyColorsViewModelProtocol) {
        didCallDidUpdateColorComponent = true
    }
}
