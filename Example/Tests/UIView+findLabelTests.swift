//
//  UIView+findLabelTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 04.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors

class UIViewFindLabelTests: QuickSpec {
    override func spec() {
        describe("The UIView+findLabel extension") {
            var sut: UIView!
            var testText: String!
            var testLabel: UILabel!

            beforeEach {
                let secondLevelView = UIView()
                let noTextLabel = UILabel()
                secondLevelView.addSubview(noTextLabel)

                testLabel = UILabel()
                testText = "TestText"
                testLabel.text = testText
                secondLevelView.addSubview(testLabel)

                sut = UIView()
                sut.addSubview(secondLevelView)
            }

            context("when calling findLabel with a text that is held by a label inside the view hierachy") {
                it("returns the label that holds the searched text") {
                    expect(sut.findLabel(withText: testText)).to(be(testLabel))
                }
            }

            context("when calling findLabel with a text that is not held by a label inside the view hierachy") {
                it("returns nil") {
                    expect(sut.findLabel(withText: "Unknown")).to(beNil())
                }
            }
        }
    }
}
