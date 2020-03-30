//
//  SheetyColorsView.swift
//  SheetyColors
//
//  Created by Christoph Wendt on 06.02.19.
//

import Foundation
import UIKit

/// The controller class managing a SheetyColors view.
public class SheetyColorsViewController: UIViewController, SheetyColorsViewControllerProtocol {
    private var previewColorView: PreviewColorView!
    private var stackView: UIStackView!
    private var selectionFeedback: UISelectionFeedbackGenerator?
    var viewModel: SheetyColorsViewModelProtocol!
    var hapticFeedbackEnabled: Bool = false
    var sliders: [GradientSlider] = []

    var previewColor: UIColor {
        return viewModel.previewColorModel.uiColor
    }

    class func create() -> SheetyColorsViewController {
        return SheetyColorsViewController(nibName: "SheetyColorsViewController", bundle: Bundle.framework)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        setupPreviewColorView()
        setupSliders()
        setupStackView()
        setupConstraints()
    }
}

// MARK: - Setting up view components

extension SheetyColorsViewController {
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
        view.addSubview(stackView)
    }
}

// MARK: - Calculating view sizes

extension SheetyColorsViewController {
    func setupConstraints() {
        let paddingTop: CGFloat = viewModel.hasTextOrMessage ? 0.0 : 15.0
        stackView.anchor(top: view.topAnchor, paddingTop: paddingTop, bottom: view.bottomAnchor, paddingBottom: 15.0, left: view.leftAnchor, paddingLeft: 15.0, right: view.rightAnchor, paddingRight: 15.0)
    }
}

// MARK: - Handling user interaction

extension SheetyColorsViewController {
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

extension SheetyColorsViewController: SheetyColorsViewDelegate {
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
