//
//  UIColor+grayscaleColorTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 26.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class UIColorGrayscaleColorTests: QuickSpec {
    override func spec() {
        describe("The UIColor+grayscaleColor extension") {
            var sut: GrayscaleColor!

            context("when calling grayscaleColor on a gray colorspace color") {
                beforeEach {
                    sut = UIColor(white: 0.5, alpha: 0.5).grayscaleColor
                }

                it("returns an HSBAColor instance") {
                    expect(sut.white).to(equal(127.0))
                    expect(sut.alpha).to(equal(50.0))
                }
            }

            context("when calling grayscaleColor on a rgb colorspace color") {
                beforeEach {
                    sut = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.5).grayscaleColor
                }

                it("returns an GraycaleColor instance") {
                    expect(sut.white).to(equal(72.0))
                    expect(sut.alpha).to(equal(50.0))
                }
            }

            context("when calling grayscaleColor on a rgb extended colorspace color") {
                beforeEach {
                    sut = UIColor(red: 2.0, green: -1.0, blue: 1.0, alpha: 2.0).grayscaleColor
                }

                it("returns an GraycaleColor instance") {
                    expect(sut.white).to(equal(72.0))
                    expect(sut.alpha).to(equal(100.0))
                }
            }
        }
    }
}
