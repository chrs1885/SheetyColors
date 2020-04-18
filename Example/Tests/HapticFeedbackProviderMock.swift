//
//  HapticFeedbackProviderMock.swift
//  SheetyColors_Tests
//
//  Created by Wendt, Christoph on 15.04.20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
@testable import SheetyColors

class HapticFeedbackProviderMock: HapticFeedbackProviderProtocol {
    var didCallGenerateInputFeedback = false
    var didCallGenerateSelectionFeedback = false
    var didCallGenerateErrorFeedback = false
    var didCallResetSelectionFeedback = false
    
    func generateInputFeedback() {
        didCallGenerateInputFeedback = true
    }
    
    func generateSelectionFeedback() {
        didCallGenerateSelectionFeedback = true
    }
    
    func generateErrorFeedback() {
        didCallGenerateErrorFeedback = true
    }
    
    func resetSelectionFeedback() {
        didCallResetSelectionFeedback = true
    }
}
