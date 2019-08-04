//
//  PreviewColorView.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 08.02.19.
//
import Capable
import UIKit

class PreviewColorView: UIView {
    var primaryKeyLabel: UILabel!
    var primaryValueLabel: UILabel!
    var secondaryKeyLabel: UILabel!
    var secondaryValueLabel: UILabel!
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
            for label in [primaryKeyLabel, primaryValueLabel, secondaryKeyLabel, secondaryValueLabel] {
                label?.textColor = textColor
            }
            infoButton.tintColor = textColor
        }
    }

    var primaryKeyText: String = "" {
        didSet {
            primaryKeyLabel.text = primaryKeyText
        }
    }

    var primaryValueText: String = "" {
        didSet {
            primaryValueLabel.text = primaryValueText
        }
    }

    var secondaryKeyText: String = "" {
        didSet {
            secondaryKeyLabel.text = secondaryKeyText
        }
    }

    var secondaryValueText: String = "" {
        didSet {
            secondaryValueLabel.text = secondaryValueText
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
        updateLabelVisibility(withDuration: 0.0)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTextColor() {
        if color.cgColor.alpha < 0.4 {
            textColor = UIColor.black
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
        primaryKeyLabel = UILabel(frame: .zero)
        primaryValueLabel = UILabel(frame: .zero)
        secondaryKeyLabel = UILabel(frame: .zero)
        secondaryValueLabel = UILabel(frame: .zero)

        let keyLabels = [primaryKeyLabel, secondaryKeyLabel]
        let valueLabels = [primaryValueLabel, secondaryValueLabel]

        for label in keyLabels {
            label?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: .regular)
        }

        for label in valueLabels {
            label?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: .light)
        }

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
            for label in [self.primaryKeyLabel, self.primaryValueLabel, self.secondaryKeyLabel, self.secondaryValueLabel] {
                label?.alpha = self.isColorViewLabelShown ? 1.0 : 0.0
            }
            self.infoButton.alpha = self.isColorViewLabelShown ? 0.0 : 1.0
        }
    }
}
