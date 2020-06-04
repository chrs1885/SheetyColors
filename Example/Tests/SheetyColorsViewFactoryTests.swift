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
            var testConfig: SheetyColorsConfigProtocol!
            var view: SheetyColorsViewController!

            context("when calling createView with a config of type .rgb") {
                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, previewBorderColor: .clear, initialColor: .red, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("returns a SheetyColorsView with RGB components") {
                    expect(view.viewModel).to(beAnInstanceOf(RGBViewModel.self))

                    let viewModel = view.viewModel as! RGBViewModel
                    expect(viewModel.colorModel).to(equal(testConfig.initialColor.rgbaColor))
                }
            }

            context("when calling createView with a config of type .hsb") {
                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, previewBorderColor: .clear, initialColor: .red, hapticFeedbackEnabled: false, title: nil, message: nil, type: .hsb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("returns a SheetyColorsView with HSB components") {
                    expect(view.viewModel).to(beAnInstanceOf(HSBViewModel.self))

                    let viewModel = view.viewModel as! HSBViewModel
                    expect(viewModel.colorModel).to(equal(testConfig.initialColor.hsbaColor))
                }
            }

            context("when calling createView with a config of type .grayscale") {
                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, previewBorderColor: .clear, initialColor: .red, hapticFeedbackEnabled: false, title: nil, message: nil, type: .grayscale)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("returns a SheetyColorsView with HSB components") {
                    expect(view.viewModel).to(beAnInstanceOf(GrayscaleViewModel.self))

                    let viewModel = view.viewModel as! GrayscaleViewModel
                    expect(viewModel.colorModel).to(equal(testConfig.initialColor.grayscaleColor))
                }
            }

            context("when calling createView with a config that has alphaEnabled set to true") {
                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: true, previewBorderColor: .clear, initialColor: .white, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("returns a SheetyColorsView an alpha slider") {
                    let viewModel = view.viewModel as! RGBViewModel
                    expect(viewModel.isAlphaEnabled).to(beTrue())
                }
            }

            context("when calling createView with a config that has set the text property") {
                var testText: String!

                beforeEach {
                    testText = "TestText"
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, previewBorderColor: .clear, initialColor: .white, hapticFeedbackEnabled: false, title: testText, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("sets hasTextOrMessage on the view model to true") {
                    let viewModel = view.viewModel as! RGBViewModel
                    expect(viewModel.hasTextOrMessage).to(beTrue())
                }
            }

            context("when calling createView with a config that doesn't have a text nor a message") {
                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, previewBorderColor: .clear, initialColor: .white, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("sets hasTextOrMessage on the view model to false") {
                    let viewModel = view.viewModel as! RGBViewModel
                    expect(viewModel.hasTextOrMessage).to(beFalse())
                }
            }

            context("when calling createView with a config with hapticFeedbackEnabled set to true") {
                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, previewBorderColor: .clear, initialColor: .white, hapticFeedbackEnabled: true, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("sets the HapticFeedbackProvider instance") {
                    expect(view.hapticFeedbackProvider).toNot(beNil())
                }
            }

            context("when calling createView with a config with hapticFeedbackEnabled set to false") {
                beforeEach {
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, previewBorderColor: .clear, initialColor: .white, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig)
                }

                it("doesn't set the HapticFeedbackProvider instance") {
                    expect(view.hapticFeedbackProvider).to(beNil())
                }
            }

            context("when calling createView with a delegate") {
                var delegateMock: SheetyColorsDelegateMock!

                beforeEach {
                    delegateMock = SheetyColorsDelegateMock()
                    testConfig = SheetyColorsConfigMock(alphaEnabled: false, previewBorderColor: .clear, initialColor: .white, hapticFeedbackEnabled: false, title: nil, message: nil, type: .rgb)
                    view = SheetyColorsViewFactory.createView(withConfig: testConfig, delegate: delegateMock)
                }

                it("sets the delegate on the view model") {
                    expect(view.viewModel.delegate).to(be(delegateMock))
                }
            }
        }
    }
}
