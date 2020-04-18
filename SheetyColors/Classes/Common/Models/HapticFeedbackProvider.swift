//
//  HapticFeedbackProvider.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 10.04.20.
//

import Foundation

class HapticFeedbackProvider: HapticFeedbackProviderProtocol {
    private var selectionFeedback: UISelectionFeedbackGenerator?

    func generateInputFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    func generateSelectionFeedback() {
        if selectionFeedback == nil {
            selectionFeedback = UISelectionFeedbackGenerator()
        }

        selectionFeedback?.prepare()
        selectionFeedback?.selectionChanged()
    }

    func generateErrorFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    func resetSelectionFeedback() {
        selectionFeedback = nil
    }
}
