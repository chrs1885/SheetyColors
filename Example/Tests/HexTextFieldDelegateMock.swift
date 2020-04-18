//
//  HexTextFieldDelegateMock.swift
//  SheetyColors_Tests
//
//  Created by Wendt, Christoph on 13.04.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import SheetyColors

class HexTextFieldDelegateMock: HexTextFieldDelegate {
    var didEditHexValue = false
    var hexValue: String?

    func hexTextField(_: HexTextField, didEditHexValue value: String) {
        didEditHexValue = true
        hexValue = value
    }
}
