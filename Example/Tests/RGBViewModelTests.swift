//
//  RGBViewModelTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 29.03.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class RGBViewModelTests: QuickSpec {
    override func spec() {
        describe("The RGBViewModel") {
            var sut: RGBViewModel!
            var delegateMock: SheetyColorsViewModelDelegateMock!

            context("after initialization") {
                var testColorModel: RGBAColor!
                var testIsAlphaEnabled: Bool!

                beforeEach {
                    delegateMock = SheetyColorsViewModelDelegateMock()
                    testIsAlphaEnabled = true
                    testColorModel = RGBAColor(red: 10.0, green: 11.0, blue: 12.0, alpha: 13.0)
                    sut = RGBViewModel(withColorModel: testColorModel, alphaEnabled: testIsAlphaEnabled)
                    sut.viewModelDelegate = delegateMock
                }

                it("sets up the instance correctly") {
                    expect(sut).to(beAnInstanceOf(RGBViewModel.self))
                }

                context("when calling primaryKeyText property") {
                    it("returns string RGB") {
                        expect(sut!.primaryKeyText).to(equal("RGB"))
                    }
                }

                context("when calling primaryValueText property") {
                    it("returns string representation of RGBA values") {
                        let expectedText = "\(Int(testColorModel.red)) \(Int(testColorModel.green)) \(Int(testColorModel.blue)) \(Int(testColorModel.alpha))%"

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
                        expect(sut!.previewColorModel as? RGBAColor).to(equal(testColorModel))
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
                        it("returns the color model's red component value") {
                            expect(sut.value(forSliderAt: 0)).to(equal(testColorModel.red))
                        }
                    }

                    context("with index 1") {
                        it("returns the color model's green component value") {
                            expect(sut.value(forSliderAt: 1)).to(equal(testColorModel.green))
                        }
                    }

                    context("with index 2") {
                        it("returns the color model's blue component value") {
                            expect(sut.value(forSliderAt: 2)).to(equal(testColorModel.blue))
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
                        it("returns 255.0") {
                            expect(sut.maximumValue(forSliderAt: 0)).to(equal(255.0))
                        }
                    }

                    context("with index 1") {
                        it("returns 255.0") {
                            expect(sut.maximumValue(forSliderAt: 1)).to(equal(255.0))
                        }
                    }

                    context("with index 2") {
                        it("returns 255.0") {
                            expect(sut.maximumValue(forSliderAt: 2)).to(equal(255.0))
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
                        it("returns correct min color model with red component of 0.0 and full opacity") {
                            let actual = sut.minimumColorModel(forSliderAt: 0) as! RGBAColor
                            let expected = testColorModel.copy() as! RGBAColor
                            expected.red = 0.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 1") {
                        it("returns correct min color model with green component of 0.0 and full opacity") {
                            let actual = sut.minimumColorModel(forSliderAt: 1) as! RGBAColor
                            let expected = testColorModel.copy() as! RGBAColor
                            expected.green = 0.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 2") {
                        it("returns correct min color model with blue component of 0.0 and full opacity") {
                            let actual = sut.minimumColorModel(forSliderAt: 2) as! RGBAColor
                            let expected = testColorModel.copy() as! RGBAColor
                            expected.blue = 0.0
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
                                let actual = sut.minimumColorModel(forSliderAt: 3) as! RGBAColor
                                let expected = RGBAColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 100.0)

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
                                let actual = sut.minimumColorModel(forSliderAt: 3) as! RGBAColor
                                let expected = RGBAColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 100.0)

                                expect(actual).to(equal(expected))
                            }
                        }
                    }
                }

                context("when calling maximumColorModel()") {
                    context("with index 0") {
                        it("returns correct max color model with red component of 255.0 and full opacity") {
                            let actual = sut.maximumColorModel(forSliderAt: 0) as! RGBAColor
                            let expected = testColorModel.copy() as! RGBAColor
                            expected.red = 255.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 1") {
                        it("returns correct max color model with green component of 255.0 and full opacity") {
                            let actual = sut.maximumColorModel(forSliderAt: 1) as! RGBAColor
                            let expected = testColorModel.copy() as! RGBAColor
                            expected.green = 255.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 2") {
                        it("returns correct max color model with blue component of 255.0 and full opacity") {
                            let actual = sut.maximumColorModel(forSliderAt: 2) as! RGBAColor
                            let expected = testColorModel.copy() as! RGBAColor
                            expected.blue = 255.0
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }

                    context("with index 3") {
                        it("returns correct max color model with alpha component of 100.0") {
                            let actual = sut.maximumColorModel(forSliderAt: 3) as! RGBAColor
                            let expected = testColorModel.copy() as! RGBAColor
                            expected.alpha = 100.0

                            expect(actual).to(equal(expected))
                        }
                    }
                }

                context("when calling thumbText()") {
                    context("with index 0") {
                        it("returns R") {
                            expect(sut.thumbText(forSliderAt: 0)).to(equal("R"))
                        }
                    }

                    context("with index 1") {
                        it("returns G") {
                            expect(sut.thumbText(forSliderAt: 1)).to(equal("G"))
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
                        testColorValue = 111.1
                    }

                    context("with index 0") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 0, value: testColorValue)
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("floors the value and updates the red component of the color model") {
                            expect(sut.colorModel.red).to(equal(floor(testColorValue)))
                        }
                    }

                    context("with index 1") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 1, value: testColorValue)
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("floors the value and updates the green component of the color model") {
                            expect(sut.colorModel.green).to(equal(floor(testColorValue)))
                        }
                    }

                    context("with index 2") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 2, value: testColorValue)
                        }

                        it("informs the delegate") {
                            expect(delegateMock.didCallDidUpdateColorComponent).to(beTrue())
                        }

                        it("floors the value and updates the blue component of the color model") {
                            expect(sut.colorModel.blue).to(equal(floor(testColorValue)))
                        }
                    }

                    context("with index 3") {
                        beforeEach {
                            sut.sliderValueChanged(forSliderAt: 3, value: testColorValue)
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
