//
//  HexTextField.swift
//  SheetyColors
//
//  Created by Wendt, Christoph on 05.04.20.
//

import UIKit

class HexTextField: UIView {
    private struct Constants {
        static let textFieldHeight: CGFloat = 17.0
        static let textFieldWidth: CGFloat = 15.0
        static let letterSpacing: CGFloat = 4.0
        static let borderWidth: CGFloat = 1.0
        static let numberOfTextFields = 6
        static let font: UIFont = UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: .light)
        static var componentWidth: CGFloat {
            CGFloat(numberOfTextFields) * textFieldWidth + CGFloat(numberOfTextFields - 1) * letterSpacing
        }
    }
    
    private var button: UIButton!
    private var textFieldStackView: UIStackView!
    private var underlineViews = [UIView]()
    private var lastHexValue: String?
    private var hapticFeedbackProvider: HapticFeedbackProviderProtocol?
    var textFields = [UITextField]()
    
    weak var delegate: HexTextFieldDelegate?
    var textColor: UIColor = .white {
        didSet {
            for i in 0 ..< Constants.numberOfTextFields {
                textFields[i].textColor = textColor
                underlineViews[i].backgroundColor = textColor
            }
        }
    }
    
    var text: String {
        set {
            let hexElements = Array(newValue)
            for i in 0 ..< Constants.numberOfTextFields {
                textFields[i].text = String(hexElements[i])
            }
            lastHexValue = newValue
        }
        
        get {
            return textFields.compactMap({ $0.text }).joined()
        }
    }
    
    init(hapticFeedbackProvider: HapticFeedbackProviderProtocol? = nil) {
        super.init(frame: CGRect.zero)
        self.hapticFeedbackProvider = hapticFeedbackProvider
        setupViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup & Layout

extension HexTextField {
    private func setupViews() {
        for _ in 1...Constants.numberOfTextFields {
            setupTextField()
        }
        
        button = UIButton(frame: .zero)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func setupTextField() {
        let textField = UITextField()
        textField.delegate = self
        textField.textAlignment = .center
        textField.textColor = textColor
        textField.font = Constants.font
        textField.tintColor = .clear
        textFields.append(textField)
        
        let underlineView = UIView(frame: .zero)
        underlineView.backgroundColor = textColor
        underlineViews.append(underlineView)
    }
    
    private func layoutViews() {
        textFieldStackView = UIStackView()
        textFieldStackView.axis = .horizontal
        textFieldStackView.spacing = Constants.letterSpacing
        addSubview(textFieldStackView)
        textFieldStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, widthConstant: Constants.componentWidth)
        
        for i in 0 ..< Constants.numberOfTextFields {
            layoutTextField(withIndex: i)
        }
        
        addSubview(button)
        button.anchor(top: textFieldStackView.topAnchor, bottom: textFieldStackView.bottomAnchor, left: textFieldStackView.leftAnchor, right: textFieldStackView.rightAnchor)
    }
    
    private func layoutTextField(withIndex index: Int) {
        let textField = textFields[index]
        let underlineView = underlineViews[index]
        
        let letterStackView = UIStackView(arrangedSubviews: [textField, underlineView])
        letterStackView.axis = .vertical
        letterStackView.spacing = 2.0
        textField.anchor(widthConstant: Constants.textFieldWidth, heightConstant: Constants.textFieldHeight)
        underlineView.anchor(width: textField.widthAnchor, heightConstant: Constants.borderWidth)
        
        textFieldStackView.addArrangedSubview(letterStackView)
    }
}

// MARK: - Text Field Highlighting

extension HexTextField {
    @objc func buttonPressed() {
        textFields.first?.becomeFirstResponder()
        setSelectedTextField(at: 0)
        for element in textFields {
            element.text = ""
        }
    }
    
    func unselectTextField() {
        if text.lengthOfBytes(using: .utf8) != Constants.numberOfTextFields, let lastValue = lastHexValue {
            text = lastValue
        }
        
        for textField in textFields {
            if textField.isFirstResponder {
                textField.resignFirstResponder()
            }
        }
    }
    
    private func setSelectedTextField(at index: Int?) {
        for i in 0 ..< Constants.numberOfTextFields {
            let underline = underlineViews[i]

            if i == index {
                underline.blink()
            } else {
                underline.layer.removeAllAnimations()
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension HexTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        setSelectedTextField(at: nil)
        delegate?.hexTextField(self, didEditHexValue: text)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty {
            if string.isHex {
                handleInsertion(currentTextField: textField, text: string.uppercased())
                hapticFeedbackProvider?.generateInputFeedback()
            } else {
                textFieldStackView.shake()
                hapticFeedbackProvider?.generateErrorFeedback()
            }
        } else {
            handleDeletion(currentTextField: textField)
            hapticFeedbackProvider?.generateInputFeedback()
        }
        
        return false
    }
    
    private func handleInsertion(currentTextField: UITextField, text: String) {
        guard let currentIndex = textFields.firstIndex(of: currentTextField) else { return }
        
        let nextIndex = currentIndex + 1
        
        if currentIndex == 0 && !currentTextField.hasText {
            currentTextField.text = text
            setSelectedTextField(at: nextIndex)
        } else {
            textFields[nextIndex].becomeFirstResponder()
            textFields[nextIndex].text = text
            if nextIndex == Constants.numberOfTextFields - 1 {
                textFields[nextIndex].resignFirstResponder()
            } else {
                setSelectedTextField(at: nextIndex + 1)
            }
        }
    }
        
    private func handleDeletion(currentTextField: UITextField) {
        guard let currentIndex = textFields.firstIndex(of: currentTextField) else { return }
        
        if currentIndex > 0 {
            let previousTextField = textFields[currentIndex - 1]
            previousTextField.becomeFirstResponder()
        }
        
        currentTextField.text = ""
        setSelectedTextField(at: currentIndex)
    }
}

// MARK: - Validation

private extension String {
    var isHex: Bool {
        let hexRegex = try! NSRegularExpression(pattern: "^[0-9a-fA-F]{\(self.count)}$")
        let range = NSRange(location: 0, length: self.count)
        return hexRegex.firstMatch(in: self, options: [], range: range) != nil
    }
}

// MARK: - Animations

private extension UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }

    func blink() {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}
