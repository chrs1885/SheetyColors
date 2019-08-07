//
//  SheetyColorsViewFactoryTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 25.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class SheetyColorsViewFactoryTests: QuickSpec {
    override func spec() {
        describe("The SheetyColorsViewFactory") {
            context("when calling create with a config of type .rgb") {
                var testConfig: SheetyColorsConfigProtocol!
                var view: SheetyColorsViewController!

                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, initialColor: .red, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("returns a SheetyColorsView with RGB components") {
                    expect(view.viewModel).to(beAnInstanceOf(RGBViewModel.self))

                    let viewModel = view.viewModel as! RGBViewModel
                    expect(viewModel.colorModel).to(equal(testConfig.initialColor.rgbaColor))
                }
            }

            context("when calling create with a config of type .hsb") {
                var testConfig: SheetyColorsConfigProtocol!
                var view: SheetyColorsViewController!

                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, initialColor: .red, hapticFeedbackEnabled: false, title: nil, message: nil, type: .hsb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("returns a SheetyColorsView with HSB components") {
                    expect(view.viewModel).to(beAnInstanceOf(HSBViewModel.self))

                    let viewModel = view.viewModel as! HSBViewModel
                    expect(viewModel.colorModel).to(equal(testConfig.initialColor.hsbaColor))
                }
            }

            context("when calling create with a config of type .grayscale") {
                var testConfig: SheetyColorsConfigProtocol!
                var view: SheetyColorsViewController!

                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, initialColor: .red, hapticFeedbackEnabled: false, title: nil, message: nil, type: .grayscale)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("returns a SheetyColorsView with HSB components") {
                    expect(view.viewModel).to(beAnInstanceOf(GrayscaleViewModel.self))

                    let viewModel = view.viewModel as! GrayscaleViewModel
                    expect(viewModel.colorModel).to(equal(testConfig.initialColor.grayscaleColor))
                }
            }

            context("when calling create with a config that has alphaEnabled set to true") {
                var testConfig: SheetyColorsConfigProtocol!
                var view: SheetyColorsViewController!

                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: true, initialColor: .white, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("returns a SheetyColorsView an alpha slider") {
                    let viewModel = view.viewModel as! RGBViewModel
                    expect(viewModel.isAlphaEnabled).to(beTrue())
                }
            }

            context("when calling create with a config that has set the text property") {
                var testConfig: SheetyColorsConfigProtocol!
                var view: SheetyColorsViewController!
                var testText: String!

                beforeEach {
                    testText = "TestText"
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, initialColor: .white, hapticFeedbackEnabled: false, title: testText, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("sets hasTextOrMessage on the view model to true") {
                    let viewModel = view.viewModel as! RGBViewModel
                    expect(viewModel.hasTextOrMessage).to(beTrue())
                }
            }

            context("when calling create with a config that doesn't have a text nor a message") {
                var testConfig: SheetyColorsConfigProtocol!
                var view: SheetyColorsViewController!

                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, initialColor: .white, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("sets hasTextOrMessage on the view model to false") {
                    let viewModel = view.viewModel as! RGBViewModel
                    expect(viewModel.hasTextOrMessage).to(beFalse())
                }
            }

            context("when calling create with a config with hapticFeedbackEnabled set to true") {
                var testConfig: SheetyColorsConfigProtocol!
                var view: SheetyColorsViewController!

                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, initialColor: .white, hapticFeedbackEnabled: true, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("sets hapticFeedbackEnabled on the view controller to true") {
                    expect(view.hapticFeedbackEnabled).to(beTrue())
                }
            }

            context("when calling create with a config with hapticFeedbackEnabled set to false") {
                var testConfig: SheetyColorsConfigProtocol!
                var view: SheetyColorsViewController!

                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, initialColor: .white, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("sets hapticFeedbackEnabled on the view controller to false") {
                    expect(view.hapticFeedbackEnabled).to(beFalse())
                }
            }
        }
    }
}
