//
//  SheetyColorsConfigTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 15.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class SheetyColorsConfigTests: QuickSpec {
    override func spec() {
        describe("The SheetyColorsConfig") {
            var sut: SheetyColorsConfig!

            context("when initialized with no parameters") {
                beforeEach {
                    sut = SheetyColorsConfig()
                }

                it("initializes a new instance by using default values") {
                    expect(sut.alphaEnabled).to(beTrue())
                    expect(sut.hapticFeedbackEnabled).to(beTrue())
                    expect(sut.initialColor).to(equal(.white))
                    expect(sut.title).to(beNil())
                    expect(sut.message).to(beNil())
                    expect(sut.type).to(equal(.rgb))
                }
            }

            context("when initialized with custom values") {
                var testInitialColor: UIColor!
                var testTitle: String!
                var testMessage: String!

                beforeEach {
                    testInitialColor = .red
                    testTitle = "TestTitle"
                    testMessage = "TestMessage"
                    sut = SheetyColorsConfig(alphaEnabled: false, hapticFeedbackEnabled: false, initialColor: testInitialColor, title: testTitle, message: testMessage, type: .rgb)
                }

                it("initializes a new instance by using custom values") {
                    expect(sut.alphaEnabled).to(beFalse())
                    expect(sut.hapticFeedbackEnabled).to(beFalse())
                    expect(sut.initialColor).to(equal(testInitialColor))
                    expect(sut.title).to(equal(testTitle))
                    expect(sut.message).to(equal(testMessage))
                    expect(sut.type).to(equal(.rgb))
                }
            }
        }
    }
}
