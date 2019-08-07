//
//  UIAlertController+customViewTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 06.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

@testable import SheetyColors
import XCTest

class UIAlertControllerCustomViewTests: XCTestCase {
    var sut: SheetyColorsController!
    var testColor: UIColor!
    var testTitle: String!
    var testMessage: String!

    override func setUp() {
        super.setUp()
        testColor = .yellow
        testTitle = "TestTitle"
        testMessage = "TestMessage"
        let config = SheetyColorsConfigMock(alphaEnabled: true, initialColor: testColor, hapticFeedbackEnabled: true, title: testTitle, message: testMessage, type: .rgb)
        sut = SheetyColorsController(withConfig: config)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCreatesAnActionSheet() {
        XCTAssertEqual(sut.preferredStyle, UIAlertController.Style.actionSheet)
    }

    func testActionSheetHasCorrectTitle() {
        XCTAssertEqual(sut.title, testTitle)
    }

    func testActionSheetHasCorrectMessage() {
        XCTAssertEqual(sut.message, testMessage)
    }

    func testColorPropertyProvidesCurrentColor() {
        XCTAssertEqual(sut.color, testColor)
    }
}
