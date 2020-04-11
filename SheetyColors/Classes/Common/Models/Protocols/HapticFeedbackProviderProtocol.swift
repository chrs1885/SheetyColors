//
//  HapticFeedbackProviderProtocol.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 10.04.20.
//

import Foundation

protocol HapticFeedbackProviderProtocol {
    func generateInputFeedback()
    func generateSelectionFeedback()
    func generateErrorFeedback()
    func resetSelectionFeedback()
}
