//
//  UIColor+hexTests.swift
//  SheetyColors_Tests
//
//  Created by Wendt, Christoph on 13.04.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Nimble
import Quick

class UIColorHexTests: QuickSpec {
    override func spec() {
        describe("The UIColor") {
            context("when initialized with a valid hex string") {
                it("creates the correct color instance") {
                    let expectedColor = UIColor(red: 250 / 255.0, green: 128 / 255.0, blue: 114 / 255.0, alpha: 1.0)
                    expect(UIColor(hex: "FA8072")).to(equal(expectedColor))
                }
            }

            context("when initialized with an invalid hex string") {
                it("returns nil") {
                    expect(UIColor(hex: "XXXXXX")).to(beNil())
                }
            }
        }
    }
}
