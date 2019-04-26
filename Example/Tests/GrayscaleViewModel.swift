//
//  GrayscaleViewModel.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 26.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class GrayscaleViewModelTests: QuickSpec {
    override func spec() {
        describe("The GrayscaleViewModel") {
            var sut: GrayscaleViewModel!
            var delegateMock: SheetyColorsViewModelDelegateMock!

            context("after initialization") {
                var testColorModel: GrayscaleColor!
                var testIsAlphaEnabled: Bool!

                beforeEach {
                    delegateMock = SheetyColorsViewModelDelegateMock()
                    testIsAlphaEnabled = true
                    testColorModel = GrayscaleColor(white: 123.0, alpha: 69.0)
                    sut = GrayscaleViewModel(withColorModel: testColorModel, alphaEnabled: testIsAlphaEnabled)
                    sut.viewModelDelegate = delegateMock
                }

                it("sets up the instance correctly") {
                    expect(sut).to(beAnInstanceOf(GrayscaleViewModel.self))
                }

                context("when calling primaryKeyText property") {
                    it("returns string Grayscale") {
                        expect(sut!.primaryKeyText).to(equal("Grayscale"))
                    }
                }

                context("when calling primaryValueText property") {
                    it("returns string representation of grascale values") {
                        let expectedText = "\(Int(testColorModel.white)) \(Int(testColorModel.alpha))%"

                        expect(sut!.primaryValueText).to(equal(expectedText))
                    }
                }

                context("when calling secondaryKeyText property") {
                    it("returns string HEX") {
                        expect(sut!.secondaryKeyText).to(equal("HEX"))
                    }
                }

                context("when calling primaryValueText property") {
                    it("returns string representation of HEX values") {
                        expect(sut!.secondaryValueText).to(equal(testColorModel.hexColor))
                    }
                }

                context("when calling previewColorModel property") {
                    it("returns the current color model") {
                        expect(sut!.previewColorModel as? GrayscaleColor).to(equal(testColorModel))
                    }
                }

                context("when calling numberOfSliders property") {
                    it("returns 2") {
                        expect(sut.numberOfSliders).to(equal(2))
                    }
                }

                context("when calling stepInterval()") {
                    context("with index 0") {
                        it("returns 1.0") {
                            expect(sut.stepInterval(forSliderAt: 0)).to(equal(1.0))
                        }
                    }

                    context("with index 1") {
                        it("returns 1.0") {
                            expect(sut.stepInterval(forSliderAt: 1)).to(equal(1.0))
                        }
                    }
                }

                context("when calling value()") {
                    context("with index 0") {
                        it("returns the color model's white component value") {
                            expect(sut.value(forSliderAt: 0)).to(equal(testColorModel.white))
                        }
                    }

                    context("with index 1") {
                        it("returns the color model's alpha component value") {
                            expect(sut.value(forSliderAt: 1)).to(equal(testColorModel.alpha))
                        }
                    }
                }

                context("when calling maximumValue()") {
                    context("with index 0") {
                        it("returns 255.0") {
                            expect(sut.maximumValue(forSliderAt: 0)).to(equal(255.0))
                        }
                    }

                    context("with index 1") {
                        it("returns 100.0") {
                            expect(sut.maximumValue(forSliderAt: 1)).to(equal(100.0))
                        }
                    }
                }

                context("when calling minimumColorModel()") {
                    context("with index 0") {
                        it("returns correct min color model with white component of 0.0 and full opacity") {
                            let actual = sut.minimumColorModel(forSliderAt: 0) as! GrayscaleColor
                            let expected = testColorModel.copy() as! GrayscaleColor
                            expected.white = 0.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 1") {
                        it("returns color model representing white color") {
                            let actual = sut.minimumColorModel(forSliderAt: 1) as! GrayscaleColor
                            let expected = GrayscaleColor(white: 255.0, alpha: 100.0)

                            expect(actual).to(equal(expected))
                        }
                    }
                }

                context("when calling maximumColorModel()") {
                    context("with index 0") {
                        it("returns correct max color model with white component of 255.0 and full opacity") {
                            let actual = sut.maximumColorModel(forSliderAt: 0) as! GrayscaleColor
                            let expected = testColorModel.copy() as! GrayscaleColor
                            expected.white = 255.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 3") {
                        it("returns correct max color model with alpha component of 100.0") {
                            let actual = sut.maximumColorModel(forSliderAt: 1) as! GrayscaleColor
                            let expected = testColorModel.copy() as! GrayscaleColor
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }
                }

                context("when calling thumbText()") {
                    context("with index 0") {
                        it("returns W") {
                            expect(sut.thumbText(forSliderAt: 0)).to(equal("W"))
                        }
                    }

                    context("with index 1") {
                        it("returns %") {
                            expect(sut.thumbText(forSliderAt: 1)).to(equal("%"))
                        }
                    }
                }

                context("when calling thumbIconName()") {
                    context("with index 0") {
                        it("returns nil") {
                            expect(sut.thumbIconName(forSliderAt: 0)).to(beNil())
                        }
                    }

                    context("with index 1") {
                        it("returns nil") {
                            expect(sut.thumbIconName(forSliderAt: 1)).to(beNil())
                        }
                    }
                }

                context("when calling sliderValueChanged()") {
                    var testColorValue: CGFloat!

                    beforeEach {
                        testColorValue = 99.9
                    }

                    context("with index 0") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 0, value: testColorValue)
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("floors the value and updates the hue component of the color model") {
                            expect(sut.colorModel.white).to(equal(floor(testColorValue)))
                        }
                    }

                    context("with index 1") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 1, value: testColorValue)
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("floors the value and updates the alpha component of the color model") {
                            expect(sut.colorModel.alpha).to(equal(floor(testColorValue)))
                        }
                    }
                }
            }
        }
    }
}
