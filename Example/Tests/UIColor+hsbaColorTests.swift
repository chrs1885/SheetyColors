//
//  UIColor+hsbaColorTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 23.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class UIColorHsbaColorTests: QuickSpec {
    override func spec() {
        describe("The UIColor+hsbaColor extension") {
            var sut: HSBAColor!

            context("when calling hsbaColor on a hsb colorspace color") {
                beforeEach {
                    sut = UIColor(hue: 0.1, saturation: 0.25, brightness: 0.75, alpha: 0.5).hsbaColor
                }

                it("returns an HSBA color model") {
                    expect(sut.hue).to(equal(36.0))
                    expect(sut.saturation).to(equal(25.0))
                    expect(sut.brightness).to(equal(75.0))
                    expect(sut.alpha).to(equal(50.0))
                }
            }

            context("when calling hsbaColor on a gray colorspace color") {
                beforeEach {
                    sut = UIColor(white: 1.0, alpha: 0.5).hsbaColor
                }

                it("returns an HSBA color model") {
                    expect(sut.saturation).to(equal(0.0))
                    expect(sut.brightness).to(equal(100.0))
                }
            }

            context("when calling hsbaColor on a rgb colorspace color") {
                beforeEach {
                    sut = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.5).hsbaColor
                }

                it("returns an HSBA color model") {
                    expect(sut.hue).to(equal(300.0))
                    expect(sut.saturation).to(equal(100.0))
                    expect(sut.brightness).to(equal(100.0))
                    expect(sut.alpha).to(equal(50.0))
                }
            }

            context("when calling hsbaColor on a rgb extended colorspace color") {
                beforeEach {
                    sut = UIColor(red: 2.0, green: -1.0, blue: 1.0, alpha: 2.0).hsbaColor
                }

                it("returns an HSBA color model") {
                    expect(sut.hue).to(equal(320.0))
                    expect(sut.saturation).to(equal(100.0))
                    expect(sut.brightness).to(equal(100.0))
                    expect(sut.alpha).to(equal(100.0))
                }
            }
        }
    }
}
