//
//  GradientSliderTests.swift
//  SheetyColors_Tests
//
//  Created by Christoph Wendt on 13.04.19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import SheetyColors
import SnapshotTesting

class GradientSliderTests: QuickSpec {
    override func spec() {
        describe("The GradientSlider") {
            var sut: GradientSlider!
            var testFrame: CGRect!

            beforeEach {
                testFrame = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 50.0)
                sut = GradientSlider()
                sut.minimumValue = 0.0
                sut.maximumValue = 10.0
            }

            context("when initialized with default values") {
                it("renders the slider control") {
                    let view = creatContainerView(withView: sut)
                    assertSnapshot(matching: view, as: .image(size: .init(width: testFrame.width, height: testFrame.height)))
                    assertSnapshot(matching: sut, as: .recursiveDescription(size: .init(width: testFrame.width, height: testFrame.height)))
                }
            }

            context("when initialized custom properties") {
                beforeEach {
                    sut.thickness = 10.0
                    sut.thumbSize = 40.0
                    sut.thumbColor = .yellow
                    sut.thumbText = "X"
                    sut.minColor = .purple
                    sut.maxColor = .magenta
                    sut.trackBorderColor = .red
                    sut.trackBorderWidth = 2.0
                }
                it("renders the slider control") {
                    let view = creatContainerView(withView: sut)
                    assertSnapshot(matching: view, as: .image(size: .init(width: testFrame.width, height: testFrame.height)))
                }
            }
        }
    }
}

func creatContainerView(withView view: UIView) -> UIView {
    let container = UIView()
    container.addSubview(view)
    view.anchor(top: container.topAnchor, bottom: container.bottomAnchor, left: container.leftAnchor, right: container.rightAnchor)

    return container
}
