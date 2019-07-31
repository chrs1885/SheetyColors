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
            var testSlider: GradientSlider!

            beforeEach {
                testSlider = GradientSlider(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
            }

            context("when RGB SheetyColors view is configured with alpha enabled") {
                beforeEach {
                    let testColor = UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 0.75).rgbaColor
                    let viewModel = RGBViewModel(withColorModel: testColor, alphaEnabled: false)
                    sut = SheetyColorsViewController.create()
                    sut.viewModel = viewModel
                    sut.hapticFeedbackEnabled = false
                    viewModel.viewModelDelegate = sut
                }

                it("renders a RGB SheetyColors view without an alpha slider") {
                    assertSnapshot(matching: sut, as: .recursiveDescription(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)))
                }

                context("when start dragging a slider") {
                    beforeEach {
                        sut.sliderDidStartEditing(testSlider)
                    }

                    it("it unhides the labels") {
                        assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                    }

                    context("when changing a slider's position") {
                        beforeEach {
                            let activeSlider = sut.sliders[0]
                            activeSlider.value = 255.0
                            sut.sliderValueDidChange(activeSlider)
                        }

                        it("it changes colors and labels accordingly") {
                            assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                        }
                    }

                    context("when lifting the finger after sliding") {
                        beforeEach {
                            sut.sliderDidStartEditing(testSlider)
                        }

                        it("it hides the labels again") {
                            assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                        }
                    }
                }
            }

            context("when RGB SheetyColors view is configured with alpha disabled") {
                beforeEach {
                    let testColor = UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 0.75).rgbaColor
                    let viewModel = RGBViewModel(withColorModel: testColor, alphaEnabled: true)
                    sut = SheetyColorsViewController.create()
                    sut.viewModel = viewModel
                    sut.hapticFeedbackEnabled = false
                    viewModel.viewModelDelegate = sut
                }

                it("renders a RGB SheetyColors view with an alpha slider") {
                    assertSnapshot(matching: sut, as: .recursiveDescription(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)))
                }
            }

            context("when HSB SheetyColors view is configured with alpha disabled") {
                beforeEach {
                    let testColor = UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 0.75).hsbaColor
                    let viewModel = HSBViewModel(withColorModel: testColor, alphaEnabled: false)
                    sut = SheetyColorsViewController.create()
                    sut.viewModel = viewModel
                    sut.hapticFeedbackEnabled = false
                    viewModel.viewModelDelegate = sut
                }

                it("renders a HSB SheetyColors view without an alpha slider") {
                    assertSnapshot(matching: sut, as: .recursiveDescription(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)))
                }
            }

            context("when HSB SheetyColors view is configured with alpha enabled") {
                beforeEach {
                    let testColor = UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 0.75).hsbaColor
                    let viewModel = HSBViewModel(withColorModel: testColor, alphaEnabled: true)
                    sut = SheetyColorsViewController.create()
                    sut.viewModel = viewModel
                    sut.hapticFeedbackEnabled = false
                    viewModel.viewModelDelegate = sut
                }

                it("renders a RGB SheetyColors view with an alpha slider") {
                    assertSnapshot(matching: sut, as: .recursiveDescription(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)))
                }
            }

            context("when Grayscale SheetyColors view is configured with alpha disabled") {
                beforeEach {
                    let testColor = UIColor(white: 0.5, alpha: 0.75).grayscaleColor
                    let viewModel = GrayscaleViewModel(withColorModel: testColor, alphaEnabled: false)
                    sut = SheetyColorsViewController.create()
                    sut.viewModel = viewModel
                    sut.hapticFeedbackEnabled = false
                    viewModel.viewModelDelegate = sut
                }

                it("renders a Grayscale SheetyColors view without an alpha slider") {
                    assertSnapshot(matching: sut, as: .recursiveDescription(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)))
                }
            }

            context("when Grayscale SheetyColors view is configured with alpha enabled") {
                beforeEach {
                    let testColor = UIColor(white: 0.5, alpha: 0.75).grayscaleColor
                    let viewModel = GrayscaleViewModel(withColorModel: testColor, alphaEnabled: true)
                    sut = SheetyColorsViewController.create()
                    sut.viewModel = viewModel
                    sut.hapticFeedbackEnabled = false
                    viewModel.viewModelDelegate = sut
                }

                it("renders a Grayscale SheetyColors view with an alpha slider") {
                    assertSnapshot(matching: sut, as: .recursiveDescription(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 300, height: 400)))
                    assertSnapshot(matching: sut, as: .image(size: .init(width: 600, height: 400)))
                }
            }
        }
    }
}
