//
//  HSBViewModelTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 22.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class HSBViewModelTests: QuickSpec {
    override func spec() {
        describe("The HSBViewModel") {
            var sut: HSBViewModel!
            var viewDelegateMock: SheetyColorsViewDelegateMock!
            var delegateMock: SheetyColorsDelegateMock!

            context("after initialization") {
                let testColorModel = HSBAColor(hue: 120.0, saturation: 94.0, brightness: 87.0, alpha: 69.0)
                let testConfig = SheetyColorsConfig(alphaEnabled: true, hapticFeedbackEnabled: true, initialColor: testColorModel.uiColor, title: "title", message: "message", type: .hsb)

                beforeEach {
                    viewDelegateMock = SheetyColorsViewDelegateMock()
                    delegateMock = SheetyColorsDelegateMock()
                    sut = HSBViewModel(withConfig: testConfig)
                    sut.viewDelegate = viewDelegateMock
                    sut.delegate = delegateMock
                }

                context("when calling hasTextOrMessage property") {
                    it("returns the correct state") {
                        expect(sut!.hasTextOrMessage).to(beTrue())
                    }
                }

                it("sets up the instance correctly") {
                    expect(sut).to(beAnInstanceOf(HSBViewModel.self))
                }

                context("when calling primaryKeyText property") {
                    it("returns string HSB") {
                        expect(sut!.primaryKeyText).to(equal("HSB"))
                    }
                }

                context("when calling primaryValueText property") {
                    it("returns string representation of HSBA values") {
                        let expectedText = "\(Int(testColorModel.hue)) \(Int(testColorModel.saturation)) \(Int(testColorModel.brightness)) \(Int(testColorModel.alpha))%"

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
                        expect(sut!.previewColorModel as? HSBAColor).to(equal(testColorModel))
                    }
                }

                context("when calling numberOfSliders property") {
                    it("returns 4") {
                        expect(sut.numberOfSliders).to(equal(4))
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

                    context("with index 2") {
                        it("returns 1.0") {
                            expect(sut.stepInterval(forSliderAt: 2)).to(equal(1.0))
                        }
                    }

                    context("with index 3") {
                        it("returns 1.0") {
                            expect(sut.stepInterval(forSliderAt: 3)).to(equal(1.0))
                        }
                    }
                }

                context("when calling value()") {
                    context("with index 0") {
                        it("returns the color model's hue component value") {
                            expect(sut.value(forSliderAt: 0)).to(equal(testColorModel.hue))
                        }
                    }

                    context("with index 1") {
                        it("returns the color model's saturation component value") {
                            expect(sut.value(forSliderAt: 1)).to(equal(testColorModel.saturation))
                        }
                    }

                    context("with index 2") {
                        it("returns the color model's brightness component value") {
                            expect(sut.value(forSliderAt: 2)).to(equal(testColorModel.brightness))
                        }
                    }

                    context("with index 3") {
                        it("returns the color model's alpha component value") {
                            expect(sut.value(forSliderAt: 3)).to(equal(testColorModel.alpha))
                        }
                    }
                }

                context("when calling maximumValue()") {
                    context("with index 0") {
                        it("returns 360.0") {
                            expect(sut.maximumValue(forSliderAt: 0)).to(equal(360.0))
                        }
                    }

                    context("with index 1") {
                        it("returns 100.0") {
                            expect(sut.maximumValue(forSliderAt: 1)).to(equal(100.0))
                        }
                    }

                    context("with index 2") {
                        it("returns 100.0") {
                            expect(sut.maximumValue(forSliderAt: 2)).to(equal(100.0))
                        }
                    }

                    context("with index 3") {
                        it("returns 100.0") {
                            expect(sut.maximumValue(forSliderAt: 3)).to(equal(100.0))
                        }
                    }
                }

                context("when calling minimumColorModel()") {
                    context("with index 0") {
                        it("returns correct min color model with hue component of 0.0 and full opacity") {
                            let actual = sut.minimumColorModel(forSliderAt: 0) as! HSBAColor
                            let expected = testColorModel.copy() as! HSBAColor
                            expected.hue = 0.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 1") {
                        it("returns correct min color model with saturation component of 0.0 and full opacity") {
                            let actual = sut.minimumColorModel(forSliderAt: 1) as! HSBAColor
                            let expected = testColorModel.copy() as! HSBAColor
                            expected.saturation = 0.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 2") {
                        it("returns correct min color model with brightness component of 0.0 and full opacity") {
                            let actual = sut.minimumColorModel(forSliderAt: 2) as! HSBAColor
                            let expected = testColorModel.copy() as! HSBAColor
                            expected.brightness = 0.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 3") {
                        var appearenceProviderMock: AppearenceProviderMock?

                        context("when appearence is set to light mode") {
                            beforeEach {
                                appearenceProviderMock = AppearenceProviderMock()
                                appearenceProviderMock!.expectedAppearence = .light
                                sut!.appearenceProvider = appearenceProviderMock!
                            }

                            it("returns color model representing white color") {
                                let actual = sut.minimumColorModel(forSliderAt: 3) as! HSBAColor
                                let expected = HSBAColor(hue: 360.0, saturation: 0.0, brightness: 100.0, alpha: 100.0)

                                expect(actual).to(equal(expected))
                            }
                        }

                        context("when appearence is set to dark mode") {
                            beforeEach {
                                appearenceProviderMock = AppearenceProviderMock()
                                appearenceProviderMock!.expectedAppearence = .dark
                                sut!.appearenceProvider = appearenceProviderMock!
                            }

                            it("returns color model representing black color") {
                                let actual = sut.minimumColorModel(forSliderAt: 3) as! HSBAColor
                                let expected = HSBAColor(hue: 360.0, saturation: 0.0, brightness: 0.0, alpha: 100.0)

                                expect(actual).to(equal(expected))
                            }
                        }
                    }
                }

                context("when calling maximumColorModel()") {
                    context("with index 0") {
                        it("returns correct max color model with hue component of 360.0 and full opacity") {
                            let actual = sut.maximumColorModel(forSliderAt: 0) as! HSBAColor
                            let expected = testColorModel.copy() as! HSBAColor
                            expected.hue = 360.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 1") {
                        it("returns correct max color model with saturation component of 100.0 and full opacity") {
                            let actual = sut.maximumColorModel(forSliderAt: 1) as! HSBAColor
                            let expected = testColorModel.copy() as! HSBAColor
                            expected.saturation = 100.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 2") {
                        it("returns correct max color model with brightness component of 100.0 and full opacity") {
                            let actual = sut.maximumColorModel(forSliderAt: 2) as! HSBAColor
                            let expected = testColorModel.copy() as! HSBAColor
                            expected.brightness = 100.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 3") {
                        it("returns correct max color model with alpha component of 100.0") {
                            let actual = sut.maximumColorModel(forSliderAt: 3) as! HSBAColor
                            let expected = testColorModel.copy() as! HSBAColor
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }
                }

                context("when calling thumbText()") {
                    context("with index 0") {
                        it("returns H") {
                            expect(sut.thumbText(forSliderAt: 0)).to(equal("H"))
                        }
                    }

                    context("with index 1") {
                        it("returns S") {
                            expect(sut.thumbText(forSliderAt: 1)).to(equal("S"))
                        }
                    }

                    context("with index 2") {
                        it("returns B") {
                            expect(sut.thumbText(forSliderAt: 2)).to(equal("B"))
                        }
                    }

                    context("with index 3") {
                        it("returns %") {
                            expect(sut.thumbText(forSliderAt: 3)).to(equal("%"))
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

                    context("with index 2") {
                        it("returns nil") {
                            expect(sut.thumbIconName(forSliderAt: 2)).to(beNil())
                        }
                    }

                    context("with index 3") {
                        it("returns nil") {
                            expect(sut.thumbIconName(forSliderAt: 3)).to(beNil())
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

                        it("informs the viewDelegate") {
                            expect(viewDelegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidSelectColor).to(beTrue())
                            expect(delegateMock.selectedColor).to(equal(sut.colorModel.uiColor))
                        }

                        it("floors the value and updates the hue component of the color model") {
                            expect(sut.colorModel.hue).to(equal(floor(testColorValue)))
                        }
                    }

                    context("with index 1") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 1, value: testColorValue)
                        }

                        it("informs the viewDelegate") {
                            expect(viewDelegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidSelectColor).to(beTrue())
                            expect(delegateMock.selectedColor).to(equal(sut.colorModel.uiColor))
                        }

                        it("floors the value and updates the saturation component of the color model") {
                            expect(sut.colorModel.saturation).to(equal(floor(testColorValue)))
                        }
                    }

                    context("with index 2") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 2, value: testColorValue)
                        }

                        it("informs the viewDelegate") {
                            expect(viewDelegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidSelectColor).to(beTrue())
                            expect(delegateMock.selectedColor).to(equal(sut.colorModel.uiColor))
                        }

                        it("floors the value and updates the brightness component of the color model") {
                            expect(sut.colorModel.brightness).to(equal(floor(testColorValue)))
                        }
                    }

                    context("with index 3") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 3, value: testColorValue)
                        }

                        it("informs the viewDelegate") {
                            expect(viewDelegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidSelectColor).to(beTrue())
                            expect(delegateMock.selectedColor).to(equal(sut.colorModel.uiColor))
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
