//
//  UIColor+rgbaColorTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 11.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class UIColorRgbaColorTests: QuickSpec {
    override func spec() {
        describe("The UIColor+rgbaColor extension") {
            var sut: RGBAColor!

            context("when calling rgbaColor on a gray colorspace color") {
                beforeEach {
                    sut = UIColor(white: 1.0, alpha: 0.5).rgbaColor
                }

                it("returns an RGBA color model") {
                    expect(sut.red).to(equal(255.0))
                    expect(sut.green).to(equal(255.0))
                    expect(sut.blue).to(equal(255.0))
                    expect(sut.alpha).to(equal(50.0))
                }
            }

            context("when calling rgbaColor on a rgb colorspace color") {
                beforeEach {
                    sut = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.5).rgbaColor
                }

                it("returns an RGBA color model") {
                    expect(sut.red).to(equal(255.0))
                    expect(sut.green).to(equal(0.0))
                    expect(sut.blue).to(equal(255.0))
                    expect(sut.alpha).to(equal(50.0))
                }
            }

            context("when calling rgbaColor on a rgb extended colorspace color") {
                beforeEach {
                    sut = UIColor(red: 2.0, green: -1.0, blue: 1.0, alpha: 2.0).rgbaColor
                }

                it("returns an RGBA color model") {
                    expect(sut.red).to(equal(255.0))
                    expect(sut.green).to(equal(0.0))
                    expect(sut.blue).to(equal(255.0))
                    expect(sut.alpha).to(equal(100.0))
                }
            }
        }
    }
}
