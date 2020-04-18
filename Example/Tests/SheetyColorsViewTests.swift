//
//  SheetyColorsViewTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 10.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors
import SnapshotTesting

class SheetyColorsViewTests: QuickSpec {
    override func spec() {
        describe("The SheetyColorsViewController") {
            var sut: SheetyColorsViewController!
            let testColor = UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 0.75)
            var testConfig = SheetyColorsConfig(alphaEnabled: false, hapticFeedbackEnabled: false, initialColor: testColor, title: nil, message: nil, type: .rgb)

            context("when RGB SheetyColors view is configured with alpha disabled") {
                beforeEach {
                    testConfig.alphaEnabled = false
                    testConfig.type = .rgb
                    let viewModel = RGBViewModel(withConfig: testConfig)
                    sut = SheetyColorsViewController(viewModel: viewModel)
                    viewModel.viewDelegate = sut
                }

                it("renders a RGB SheetyColors view without an alpha slider") {
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "rgb_without_alpha_normal")
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)), named: "rgb_without_alpha_wide")
                }

                context("when start dragging a slider") {
                    var testSlider: GradientSlider!

                    beforeEach {
                        testSlider = GradientSlider(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
                        sut.viewDidLoad()
                        sut.sliderDidStartEditing(testSlider)
                    }

                    it("it unhides the labels") {
                        assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "rgb_dragging_slider_displays_labels")
                    }

                    context("when changing a slider's position") {
                        beforeEach {
                            let activeSlider = sut.sliders[0]
                            activeSlider.value = 255.0
                            sut.sliderValueDidChange(activeSlider)
                        }

                        it("it changes colors and labels accordingly") {
                            assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "rgb_dragging_slider_changes_values")
                        }
                    }

                    context("when lifting the finger after sliding") {
                        beforeEach {
                            sut.sliderDidStartEditing(testSlider)
                        }

                        it("it hides the labels again") {
                            assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "rgb_stop_dragging_hides_labels")
                        }
                    }
                }
            }

            context("when RGB SheetyColors view is configured with alpha enabled") {
                beforeEach {
                    testConfig.alphaEnabled = true
                    testConfig.type = .rgb
                    let viewModel = RGBViewModel(withConfig: testConfig)
                    sut = SheetyColorsViewController(viewModel: viewModel)
                    viewModel.viewDelegate = sut
                }

                it("renders a RGB SheetyColors view with an alpha slider") {
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "rgb_with_alpha_normal")
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)), named: "rgb_with_alpha_wide")
                }
            }

            context("when HSB SheetyColors view is configured with alpha disabled") {
                beforeEach {
                    testConfig.alphaEnabled = false
                    testConfig.type = .hsb
                    let viewModel = HSBViewModel(withConfig: testConfig)
                    sut = SheetyColorsViewController(viewModel: viewModel)
                    viewModel.viewDelegate = sut
                }

                it("renders a HSB SheetyColors view without an alpha slider") {
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "hsb_without_alpha_normal")
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)), named: "hsb_without_alpha_wide")
                }
            }

            context("when HSB SheetyColors view is configured with alpha enabled") {
                beforeEach {
                    testConfig.alphaEnabled = true
                    testConfig.type = .hsb
                    let viewModel = HSBViewModel(withConfig: testConfig)
                    sut = SheetyColorsViewController(viewModel: viewModel)
                    viewModel.viewDelegate = sut
                }

                it("renders a HSB SheetyColors view with an alpha slider") {
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "hsb_with_alpha_normal")
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)), named: "hsb_with_alpha_wide")
                }
            }

            context("when Grayscale SheetyColors view is configured with alpha disabled") {
                beforeEach {
                    testConfig.alphaEnabled = false
                    testConfig.type = .grayscale
                    let viewModel = GrayscaleViewModel(withConfig: testConfig)
                    sut = SheetyColorsViewController(viewModel: viewModel)
                    viewModel.viewDelegate = sut
                }

                it("renders a Grayscale SheetyColors view without an alpha slider") {
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "grayscale_without_alpha_normal")
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)), named: "grayscale_without_alpha_wide")
                }
            }

            context("when Grayscale SheetyColors view is configured with alpha enabled") {
                beforeEach {
                    testConfig.alphaEnabled = true
                    testConfig.type = .grayscale
                    let viewModel = GrayscaleViewModel(withConfig: testConfig)
                    sut = SheetyColorsViewController(viewModel: viewModel)
                    viewModel.viewDelegate = sut
                }

                it("renders a Grayscale SheetyColors view with an alpha slider") {
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)), named: "grayscale_with_alpha_normal")
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)), named: "grayscale_with_alpha_wide")
                }
            }
        }
    }
}
