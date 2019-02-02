//
//  UIView+findLabel.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 02.02.19.
//

extension UIView {
    func findLabel(withText text: String) -> UILabel? {
        if let label = self as? UILabel, label.text == text {
            return label
        }

        for subview in subviews {
            if let found = subview.findLabel(withText: text) {
                return found
            }
        }

        return nil
    }
}
