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
    var hexValueTextField: HexTextField!
    var infoButton: UIButton!
    var labelStackView: UIStackView!
    var colorLayer: CALayer!
    var transparencyPatternLayer: CALayer!
    var isColorViewLabelShown: Bool!
    var hapticFeedbackProvider: HapticFeedbackProviderProtocol?
    
    var color: UIColor = .clear {
        didSet {
            colorLayer?.backgroundColor = color.cgColor
            hexValueTextField.unselectTextField()
            updateTextColor()
        }
    }

    var textColor: UIColor = .clear {
        didSet {
            for label in [primaryTitleLabel, primaryValueLabel, hexTitleLabel] {
                label?.textColor = textColor
            }
            hexValueTextField.textColor = textColor
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

    var hexKeyText: String = "" {
        didSet {
            hexTitleLabel.text = hexKeyText
        }
    }

    var hexValueText: String = "" {
        didSet {
            hexValueTextField.text = hexValueText
        }
    }

    convenience init(withColor color: UIColor, hapticFeedbackProvider: HapticFeedbackProviderProtocol? = nil) {
        self.init(frame: .zero)
        self.color = color
        self.hapticFeedbackProvider = hapticFeedbackProvider
        colorLayer.backgroundColor = self.color.cgColor
        updateTextColor()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isColorViewLabelShown = true
        setupColorView()
        setupLabels()
        setupButton()
        setupLayout()
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
        hexValueTextField = HexTextField(hapticFeedbackProvider: hapticFeedbackProvider)

        for label in [primaryTitleLabel, hexTitleLabel] {
            label?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: .regular)
        }

        primaryValueLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: .light)
    }

    private func setupButton() {
        infoButton = UIButton(type: UIButton.ButtonType.infoDark)
        addSubview(infoButton)
        infoButton.addTarget(self, action: #selector(infoButtonPressed(_:)), for: .touchUpInside)
    }

    private func setupLayout() {
        #warning("This constraint needs to have a lower prio, since it will always break if you are using the picker outside of an action sheet")
        anchor(heightConstant: 100.0)
        infoButton.anchor(top: topAnchor, paddingTop: 10.0, right: rightAnchor, paddingRight: 10.0)
        
        let keysyStackView = UIStackView(arrangedSubviews: [primaryTitleLabel, hexTitleLabel])
        keysyStackView.axis = .vertical
        keysyStackView.alignment = .leading
        keysyStackView.spacing = 4.0

        let valuesStackView = UIStackView(arrangedSubviews: [primaryValueLabel, hexValueTextField])
        valuesStackView.axis = .vertical
        valuesStackView.alignment = .leading
        valuesStackView.spacing = 4.0

        labelStackView = UIStackView(arrangedSubviews: [keysyStackView, valuesStackView])
        labelStackView.axis = .horizontal
        labelStackView.alignment = .top
        labelStackView.spacing = 8.0
        addSubview(labelStackView)
        labelStackView.anchor(top: topAnchor, paddingTop: 10.0, left: leftAnchor, paddingLeft: 10.0)
    }

    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    private func setupTextFieldHandler() {
        hexValueTextField.delegate = self
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
            hexValueTextField.unselectTextField()
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

extension PreviewColorView: HexTextFieldDelegate {
    func hexTextField(_ hextTextField: HexTextField, didEditHexValue value: String) {
        delegate?.previewColorView(self, didEditHexValue: value)
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
