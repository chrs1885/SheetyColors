//
//  HexTextFieldTests.swift
//  SheetyColors_Tests
//
//  Created by Wendt, Christoph on 13.04.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Nimble
import Quick
import SnapshotTesting
@testable import SheetyColors

class HexTextFieldTests: QuickSpec {
    override func spec() {
        describe("The HexTextField") {
            var window: UIWindow!
            
            beforeEach {
                window = UIWindow(frame: UIScreen.main.bounds)
            }

            afterEach {
                window = nil
            }
            
            context("when initialized") {
                var sut: HexTextField!
                var hapticFeedbackProviderMock: HapticFeedbackProviderMock!
                var testFrame: CGRect!
                
                beforeEach {
                    testFrame = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 50.0)
                    hapticFeedbackProviderMock = HapticFeedbackProviderMock()
                    sut = HexTextField(hapticFeedbackProvider: hapticFeedbackProviderMock)
                    sut.text = "ABCDEF"
                    window.makeKeyAndVisible()
                    window.addSubview(sut)
                    sut.anchor(top: window.topAnchor, bottom: window.bottomAnchor, left: window.leftAnchor, right: window.rightAnchor)
                }
                
                afterEach {
                    sut = nil
                }
                
                it("manages 6 single textFields") {
                    assertSnapshot(matching: sut, as: .image(size: .init(width: testFrame.width, height: testFrame.height)), named: "initial_state")
                }
                
                context("setting a new text color") {
                    beforeEach {
                        sut.textColor = .blue
                    }
                    
                    it("applies the text color on every single text field") {
                        for textField in sut.textFields {
                            expect(textField.textColor).to(equal(UIColor.blue))
                        }
                    }
                }
                
                context("setting a new text") {
                    let testText = ["a", "b", "c", "d", "e", "f"]
                    beforeEach {
                        sut.text = testText.joined()
                    }
                    
                    it("applies the text color on every single text field") {
                        for index in 0 ..< sut.textFields.count {
                            let currentTextField = sut.textFields[index]
                            expect(currentTextField.text).to(equal(testText[index]))
                        }
                    }
                }
                
                context("after a new valid hex code was provided by the user") {
                    var delegateMock: HexTextFieldDelegateMock!
                    var testHex: String!
                    
                    beforeEach {
                        testHex = "FF0000"
                        delegateMock = HexTextFieldDelegateMock()
                        sut.delegate = delegateMock
                        sut.text = testHex
                        sut.textFieldDidEndEditing(UITextField())
                    }
                    
                    it("informs its delegate") {
                        expect(delegateMock.didEditHexValue).to(beTrue())
                        expect(delegateMock.hexValue).to(equal(testHex))
                    }
                }

                
                context("after the hex text field was selected") {
                    var textField: UITextField!
                    var nextTextField: UITextField!

                    beforeEach {
                        textField = sut.textFields[0]
                        nextTextField = sut.textFields[1]
                        
                        sut.buttonPressed()
                    }
                    
                    it("removes the text") {
                        assertSnapshot(matching: sut, as: .image(size: .init(width: testFrame.width, height: testFrame.height)), named: "text_field_selected")
                    }
                    
                    context("when the user types in a valid hex element") {
                        let testHexElement = "D"

                        beforeEach {
                            _ = sut.textField(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: testHexElement)
                        }

                        it("sets the text field's text to the new value") {
                            expect(textField.text).to(equal(testHexElement))
                        }

                        it("sets the next text field as first responder") {
                            expect(textField.isFirstResponder).to(beTrue())
                        }

                        it("generates a haptic input feedback") {
                            expect(hapticFeedbackProviderMock.didCallGenerateInputFeedback).to(beTrue())
                        }

                        context("when the deletes the hex element again") {
                            let testHexElement = ""

                            beforeEach {
                                textField = sut.textFields[1]
                                nextTextField = sut.textFields[0]
                                _ = sut.textField(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 1), replacementString: testHexElement)
                            }

                            it("deletes the text field's text to the new value") {
                                expect(textField.text).to(beEmpty())
                            }
                            
                            it("sets the previous text field as first responder") {
                                expect(nextTextField.isFirstResponder).to(beTrue())
                            }

                            it("generates a haptic input feedback") {
                                expect(hapticFeedbackProviderMock.didCallGenerateInputFeedback).to(beTrue())
                            }
                        }
                    }

                    context("when the user types in an invalid hex element") {
                        let testHexElement = "X"

                        beforeEach {
                            _ = sut.textField(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 1), replacementString: testHexElement)
                        }

                        it("does not set the text field's text to the new value") {
                            expect(textField.text).to(beEmpty())
                        }

                        it("does not change the first responder") {
                            expect(textField.isFirstResponder).to(beTrue())
                        }

                        it("generates a haptic error feedback") {
                            expect(hapticFeedbackProviderMock.didCallGenerateErrorFeedback).to(beTrue())
                        }
                    }
                    
                    context("calling unselectTextField") {
                        beforeEach {
                            sut.unselectTextField()
                        }
                        
                        it("resets text to last valid value") {
                            assertSnapshot(matching: sut, as: .image(size: .init(width: testFrame.width, height: testFrame.height)), named: "text_field_unselected")
                        }
                    }
                }
            }
        }
    }
}
