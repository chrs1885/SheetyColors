//
//  PreviewColorView.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 08.02.19.
//
import Capable
import UIKit

class PreviewColorView: UIView {
    weak var delegate: PreviewColorViewDelegate?
    var primaryTitleLabel: UILabel!
    var primaryValueLabel: UILabel!
    var hexTitleLabel: UILabel!
    var hexValueTextField: UITextField!
    var infoButton: UIButton!
    var labelStackView: UIStackView!
    var colorLayer: CALayer!
    var transparencyPatternLayer: CALayer!
    var isColorViewLabelShown: Bool!

    var color: UIColor = .clear {
        didSet {
            colorLayer?.backgroundColor = color.cgColor
            updateTextColor()
        }
    }

    var textColor: UIColor = .clear {
        didSet {
            for label in [primaryTitleLabel, primaryValueLabel, hexTitleLabel] {
                label?.textColor = textColor
            }
            
            hexValueTextField?.textColor = textColor
            infoButton.tintColor = textColor
        }
    }

    var primaryKeyText: String = "" {
        didSet {
            primaryTitleLabel.text = primaryKeyText
        }
    }

    var primaryValueText: String = "" {
        didSet {
            primaryValueLabel.text = primaryValueText
        }
    }

    var secondaryKeyText: String = "" {
        didSet {
            hexTitleLabel.text = secondaryKeyText
        }
    }

    var hexValueText: String = "" {
        didSet {
            hexValueTextField.text = hexValueText
        }
    }

    convenience init(withColor color: UIColor) {
        self.init(frame: .zero)
        self.color = color
        colorLayer.backgroundColor = self.color.cgColor
        updateTextColor()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isColorViewLabelShown = false
        setupColorView()
        setupLabels()
        setupButton()
        setupConstraints()
        setupGestureRecognizer()
        setupTextFieldHandler()
        updateLabelVisibility(withDuration: 0.0)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTextColor() {
        if color.cgColor.alpha < 0.4 {
            guard let defaultTextColor = UIColor(named: "PrimaryColor", in: Bundle.framework, compatibleWith: nil) else { return }
            textColor = defaultTextColor
        } else {
            textColor = UIColor.getTextColor(onBackgroundColor: color)!
        }
    }

    private func setupColorView() {
        transparencyPatternLayer = CALayer()
        if let transparencyIcon = UIImage(named: "Transparency", in: Bundle.framework, compatibleWith: nil) {
            transparencyPatternLayer.backgroundColor = UIColor(patternImage: transparencyIcon).cgColor
        }
        layer.addSublayer(transparencyPatternLayer)

        colorLayer = CALayer()
        layer.addSublayer(colorLayer)
    }

    private func setupLabels() {
        primaryTitleLabel = UILabel(frame: .zero)
        primaryValueLabel = UILabel(frame: .zero)
        hexTitleLabel = UILabel(frame: .zero)
        hexValueTextField = UITextField(frame: .zero)

        let keyLabels = [primaryTitleLabel, hexTitleLabel]
        let valueLabels = [primaryValueLabel, hexValueTextField]

        for label in keyLabels {
            label?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: .regular)
        }

        primaryValueLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: .light)
        hexValueTextField?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: .light)
        
        guard let keyViews = keyLabels as? [UIView], let valueViews = valueLabels as? [UIView] else { return }

        let keyLabelStackView = UIStackView(arrangedSubviews: keyViews)
        keyLabelStackView.axis = .vertical

        let valueLabelStackView = UIStackView(arrangedSubviews: valueViews)
        valueLabelStackView.axis = .vertical

        labelStackView = UIStackView(arrangedSubviews: [keyLabelStackView, valueLabelStackView])
        labelStackView.axis = .horizontal
        labelStackView.spacing = 8.0
        addSubview(labelStackView)
    }

    private func setupButton() {
        infoButton = UIButton(type: UIButton.ButtonType.infoDark)
        addSubview(infoButton)
        infoButton.addTarget(self, action: #selector(infoButtonPressed(_:)), for: .touchUpInside)
    }

    private func setupConstraints() {
        anchor(heightConstant: 100.0)
        labelStackView.anchor(top: topAnchor, paddingTop: 10.0, left: leftAnchor, paddingLeft: 10.0)
        infoButton.anchor(top: topAnchor, paddingTop: 10.0, right: rightAnchor, paddingRight: 10.0)
    }

    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    private func setupTextFieldHandler() {
        hexValueTextField.delegate = self
        hexValueTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        hexValueTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEndOnExit)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        colorLayer.frame = bounds
        transparencyPatternLayer.frame = bounds
    }
}

// MARK: - Handle User Interaction

extension PreviewColorView {
    @objc func handleTap(_: UIView) {
        if isColorViewLabelShown {
            hideLabels()
        } else {
            displayLabels()
        }
    }

    @objc func infoButtonPressed(_: UIButton) {
        if !isColorViewLabelShown {
            displayLabels()
        }
    }
}

// MARK: - Handle User Interaction

extension PreviewColorView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard
            let text = textField.text else {
                return
        }
        
        delegate?.previewColorView(self, didEditHexValue: text)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         guard
            let text = textField.text,
            let regex = try? NSRegularExpression(pattern: "^[0-9a-fA-F]{6}$") else {
           return false
       }
        
        let range = NSRange(location: 0, length: text.utf16.count)
        return  regex.firstMatch(in: text, options: [], range: range) != nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard
            let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string),
            let regex = try? NSRegularExpression(pattern: "^[0-9a-fA-F]{0,6}$") else {
            return false
        }
        
        let range = NSRange(location: 0, length: updatedString.utf16.count)
        return  regex.firstMatch(in: updatedString, options: [], range: range) != nil
    }
}

// MARK: - Animations

extension PreviewColorView {
    func displayLabels(withDuration duration: TimeInterval = 0.4) {
        guard !isColorViewLabelShown else { return }

        isColorViewLabelShown = true
        updateLabelVisibility(withDuration: duration)
    }

    func hideLabels(withDuration duration: TimeInterval = 0.4) {
        guard isColorViewLabelShown else { return }

        isColorViewLabelShown = false
        updateLabelVisibility(withDuration: duration)
    }

    func updateLabelVisibility(withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            for label in [self.primaryTitleLabel, self.primaryValueLabel, self.hexTitleLabel] {
                label?.alpha = self.isColorViewLabelShown ? 1.0 : 0.0
            }
            self.hexValueTextField?.alpha = self.isColorViewLabelShown ? 1.0 : 0.0
            self.infoButton.alpha = self.isColorViewLabelShown ? 0.0 : 1.0
        }
    }
}
