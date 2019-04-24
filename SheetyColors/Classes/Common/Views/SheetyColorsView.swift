//
//  SheetyColorsView.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 06.02.19.
//

import Foundation
import UIKit

class SheetyColorsView: UIView, SheetyColorsViewProtocol {
    private var previewColorView: PreviewColorView!
    private var stackView: UIStackView!
    private var selectionFeedback: UISelectionFeedbackGenerator?
    var viewModel: SheetyColorsViewModelProtocol
    var hapticFeedbackEnabled: Bool
    var sliders: [GradientSlider] = []

    var previewColor: UIColor {
        return viewModel.previewColorModel.uiColor
    }

    init(withViewModel viewModel: SheetyColorsViewModelProtocol, hapticFeedbackEnabled: Bool) {
        self.viewModel = viewModel
        self.hapticFeedbackEnabled = hapticFeedbackEnabled

        super.init(frame: .zero)
        setupView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        setupPreviewColorView()
        setupSliders()
        setupStackView()
        setupConstraints()
    }
}

// MARK: - Setting up view components

extension SheetyColorsView {
    func setupSliders() {
        for index in 0 ..< viewModel.numberOfSliders {
            let slider = GradientSlider()
            slider.hasRainbow = viewModel.rainbowEnabled(forSliderAt: index)
            slider.stepInterval = viewModel.stepInterval(forSliderAt: index)
            slider.maximumValue = viewModel.maximumValue(forSliderAt: index)
            slider.value = viewModel.value(forSliderAt: index)
            slider.minColor = viewModel.minimumColorModel(forSliderAt: index).uiColor
            slider.maxColor = viewModel.maximumColorModel(forSliderAt: index).uiColor

            if let text = viewModel.thumbText(forSliderAt: index) {
                slider.thumbText = text
            } else if let iconName = viewModel.thumbIconName(forSliderAt: index) {
                slider.thumbIcon = UIImage(named: iconName)
            }

            slider.addTarget(self, action: #selector(sliderDidStartEditing(_:)), for: .touchDown)
            slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
            slider.addTarget(self, action: #selector(sliderDidEndEditing(_:)), for: .touchUpInside)

            sliders.append(slider)
        }
    }

    func setupPreviewColorView() {
        previewColorView = PreviewColorView(withColor: viewModel.previewColorModel.uiColor)
        previewColorView.primaryKeyText = viewModel.primaryKeyText
        previewColorView.primaryValueText = viewModel.primaryValueText
        previewColorView.secondaryKeyText = viewModel.secondaryKeyText
        previewColorView.secondaryValueText = viewModel.secondaryValueText
    }

    func setupStackView() {
        var subviews: [UIView] = [previewColorView]
        subviews.append(contentsOf: sliders)

        stackView = UIStackView(arrangedSubviews: subviews)
        stackView.axis = .vertical
        stackView.spacing = 10.0
        addSubview(stackView)
    }
}

// MARK: - Calculating view sizes

extension SheetyColorsView {
    func setupConstraints() {
        stackView.anchor(top: topAnchor, paddingTop: 15.0, bottom: bottomAnchor, left: leftAnchor, paddingLeft: 15.0, right: rightAnchor, paddingRight: 15.0)
    }

    override var intrinsicContentSize: CGSize {
        return stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

// MARK: - Handling user interaction

extension SheetyColorsView {
    @objc func sliderDidStartEditing(_: GradientSlider) {
        if hapticFeedbackEnabled {
            selectionFeedback = UISelectionFeedbackGenerator()
        }

        previewColorView.displayLabels()
    }

    @objc func sliderValueDidChange(_ sender: GradientSlider) {
        if let index = sliders.firstIndex(of: sender) {
            viewModel.sliderValueChanged(forSliderAt: index, value: sender.value)
        }

        if hapticFeedbackEnabled {
            selectionFeedback?.prepare()
            selectionFeedback?.selectionChanged()
        }
    }

    @objc func sliderDidEndEditing(_: GradientSlider) {
        selectionFeedback = nil
        previewColorView.hideLabels()
    }
}

// MARK: - Data binding

extension SheetyColorsView: SheetyColorsViewModelDelegate {
    func didUpdateColorComponent(in viewModel: SheetyColorsViewModelProtocol) {
        previewColorView.primaryValueText = viewModel.primaryValueText
        previewColorView.secondaryValueText = viewModel.secondaryValueText

        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        previewColorView.color = viewModel.previewColorModel.uiColor
        for index in 0 ..< viewModel.numberOfSliders {
            let slider = sliders[index]
            slider.minColor = viewModel.minimumColorModel(forSliderAt: index).uiColor
            slider.maxColor = viewModel.maximumColorModel(forSliderAt: index).uiColor
        }
        CATransaction.commit()
    }
}
