//
//  GradientSlider.swift
//  GradientSlider
//
//  Created by Jonathan Hull on 8/5/15.
//  Copyright © 2015 Jonathan Hull. All rights reserved.
//

import UIKit

@IBDesignable class GradientSlider: UIControl {
    static var defaultThickness: CGFloat = 3.0
    static var defaultThumbSize: CGFloat = 28.0

    // MARK: Properties

    var hasRainbow: Bool = false {
        didSet {
            updateTrackColors()
        }
    }

    var minColor: UIColor = UIColor.blue {
        didSet {
            updateTrackColors()
        }
    }

    var maxColor: UIColor = UIColor.orange {
        didSet {
            updateTrackColors()
        }
    }

    var value: CGFloat {
        get {
            return sliderValue
        }
        set {
            let val = newValue - newValue.truncatingRemainder(dividingBy: stepInterval)
            setValue(val, animated: true)
        }
    }

    func setValue(_ value: CGFloat, animated: Bool = true) {
        sliderValue = max(min(value, maximumValue), minimumValue)
        updateThumbPosition(animated: animated)
    }

    var minimumValue: CGFloat = 0.0
    var maximumValue: CGFloat = 1.0
    var stepInterval: CGFloat = 0.0 {
        didSet {
            sliderValue = value - value.truncatingRemainder(dividingBy: stepInterval)
        }
    }

    var continuous: Bool = true

    var thickness: CGFloat = defaultThickness {
        didSet {
            trackLayer.cornerRadius = thickness / 2.0
            layer.setNeedsLayout()
        }
    }

    var trackBorderColor: UIColor? {
        set {
            trackLayer.borderColor = newValue?.cgColor
        }
        get {
            if let color = trackLayer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
    }

    var trackBorderWidth: CGFloat {
        set {
            trackLayer.borderWidth = newValue
        }
        get {
            return trackLayer.borderWidth
        }
    }

    var thumbSize: CGFloat = defaultThumbSize {
        didSet {
            thumbLayer.cornerRadius = thumbSize / 2.0
            thumbLayer.bounds = CGRect(x: 0, y: 0, width: thumbSize, height: thumbSize)
            invalidateIntrinsicContentSize()
        }
    }

    var thumbIcon: UIImage? {
        didSet {
            thumbIconLayer.contents = thumbIcon?.cgImage
        }
    }

    var thumbText: String? {
        didSet {
            thumbTextLayer.string = thumbText
        }
    }

    var thumbColor: UIColor {
        get {
            return UIColor(cgColor: thumbLayer.backgroundColor!)
        }
        set {
            thumbLayer.backgroundColor = newValue.cgColor
        }
    }

    // MARK: - Private Properties

    private var sliderValue: CGFloat = 0.0 // default 0.0. this value will be pinned to min/max

    private var thumbLayer: CALayer = {
        let thumb = CALayer()
        thumb.cornerRadius = defaultThumbSize / 2.0
        thumb.bounds = CGRect(x: 0, y: 0, width: defaultThumbSize, height: defaultThumbSize)
        thumb.backgroundColor = UIColor.white.cgColor

        if let shadowColor = UIColor(named: "sliderThumbShadowColor") {
            thumb.shadowColor = shadowColor.cgColor
            thumb.shadowOffset = CGSize(width: 0.0, height: 2.5)
            thumb.shadowRadius = 2.0
            thumb.shadowOpacity = 0.25
        }

        if let borderColor = UIColor(named: "sliderThumbBorderColor") {
            thumb.borderColor = borderColor.cgColor
            thumb.borderWidth = 0.5
        }

        return thumb
    }()

    private var trackLayer: CAGradientLayer = {
        let track = CAGradientLayer()
        track.cornerRadius = defaultThickness / 2.0
        track.startPoint = CGPoint(x: 0.0, y: 0.5)
        track.endPoint = CGPoint(x: 1.0, y: 0.5)
        track.locations = [0.0, 1.0]
        track.colors = [UIColor.blue.cgColor, UIColor.orange.cgColor]

        if let borderColor = UIColor(named: "sliderThumbBorderColor") {
            track.borderColor = borderColor.cgColor
        }

        return track
    }()

    private var thumbIconLayer: CALayer = {
        let size = defaultThumbSize - 4
        let iconLayer = CALayer()
        iconLayer.cornerRadius = size / 2.0
        iconLayer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        iconLayer.backgroundColor = UIColor.clear.cgColor
        return iconLayer
    }()

    private var thumbTextLayer: VerticallyCenteredTextLayer = {
        let size = defaultThumbSize - 4
        let textLayer = VerticallyCenteredTextLayer()
        textLayer.cornerRadius = size / 2.0
        textLayer.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.foregroundColor = UIColor.gray.cgColor
        textLayer.fontSize = 15.0

        return textLayer
    }()

    // MARK: - Init

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonSetup() {
        layer.delegate = self
        layer.addSublayer(trackLayer)
        layer.addSublayer(thumbLayer)
        thumbLayer.addSublayer(thumbIconLayer)
        thumbLayer.addSublayer(thumbTextLayer)
    }

    // MARK: - Layout

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: thumbSize)
    }

    func setupConstraints() {
        anchor(heightConstant: 40.0)
    }

    //    func alignmentRectInsets() -> UIEdgeInsets {
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 4.0, left: 2.0, bottom: 4.0, right: 2.0)
    }

    override func layoutSublayers(of layer: CALayer) {
        if layer != self.layer { return }

        var w = bounds.width
        let h = bounds.height
        let left: CGFloat = 2.0
        let right: CGFloat = 2.0

        w -= left + right

        trackLayer.bounds = CGRect(x: 0, y: 0, width: w, height: thickness)
        trackLayer.position = CGPoint(x: w / 2.0 + left, y: h / 2.0)

        let halfSize = thumbSize / 2.0
        let layerSize = thumbSize - 8.0

        thumbIconLayer.cornerRadius = layerSize / 2.0
        thumbIconLayer.masksToBounds = true
        thumbIconLayer.position = CGPoint(x: halfSize, y: halfSize)
        thumbIconLayer.bounds = CGRect(x: 0, y: 0, width: layerSize, height: layerSize)

        thumbTextLayer.cornerRadius = layerSize / 2.0
        thumbTextLayer.position = CGPoint(x: halfSize, y: halfSize)
        thumbTextLayer.bounds = CGRect(x: 0, y: 0, width: layerSize, height: layerSize)

        updateThumbPosition(animated: false)
    }

    // MARK: - Touch Tracking

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        let pt = touch.location(in: self)

        let center = thumbLayer.position
        let diameter = max(thumbSize, 44.0)
        let r = CGRect(x: center.x - diameter / 2.0, y: center.y - diameter / 2.0, width: diameter, height: diameter)
        if r.contains(pt) {
            sendActions(for: UIControl.Event.touchDown)
            return true
        }
        return false
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        let pt = touch.location(in: self)
        var newValue = valueForLocation(point: pt)
        var difference = abs(value - newValue)
        if difference >= stepInterval {
            let remainder = difference.truncatingRemainder(dividingBy: stepInterval)
            difference -= remainder
            newValue = newValue > value ? value + difference : value - difference
            setValue(newValue, animated: false)
            if continuous {
                sendActions(for: UIControl.Event.valueChanged)
            }
        }
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        if let pt = touch?.location(in: self) {
            var newValue = valueForLocation(point: pt)
            var difference = abs(value - newValue)
            if difference >= stepInterval {
                let remainder = difference.truncatingRemainder(dividingBy: stepInterval)
                difference -= remainder
                newValue = newValue > value ? value + difference : value - difference
                setValue(newValue, animated: false)
            }
        }
        sendActions(for: [UIControl.Event.valueChanged, UIControl.Event.touchUpInside])
    }

    // MARK: - Private Functions

    private func updateThumbPosition(animated: Bool) {
        let diff = maximumValue - minimumValue
        let perc = CGFloat((value - minimumValue) / diff)

        let halfHeight = bounds.height / 2.0
        let trackWidth = trackLayer.bounds.width - thumbSize
        let left = trackLayer.position.x - trackWidth / 2.0

        if !animated {
            CATransaction.begin() // Move the thumb position without animations
            CATransaction.setValue(true, forKey: kCATransactionDisableActions)
            thumbLayer.position = CGPoint(x: left + (trackWidth * perc), y: halfHeight)
            CATransaction.commit()
        } else {
            thumbLayer.position = CGPoint(x: left + (trackWidth * perc), y: halfHeight)
        }
    }

    private func valueForLocation(point: CGPoint) -> CGFloat {
        var left = bounds.origin.x
        var w = bounds.width
        w -= 4.0
        left += 2.0

        let diff = CGFloat(maximumValue - minimumValue)
        let perc = max(min((point.x - left) / w, 1.0), 0.0)

        return (perc * diff) + CGFloat(minimumValue)
    }

    private func updateTrackColors() {
        if !hasRainbow {
            // The colors to use
            trackLayer.colors = [minColor.cgColor, maxColor.cgColor]

            // The location of each color, from left to right (min value 0, max value 1)
            trackLayer.locations = [0.0, 1.0]
            return
        }

        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var l: CGFloat = 0.0
        var a: CGFloat = 1.0

        minColor.getHue(&h, saturation: &s, brightness: &l, alpha: &a)

        let cnt = 4
        let step: CGFloat = 1.0 / CGFloat(cnt)
        let locations: [CGFloat] = (0 ... cnt).map { i in step * CGFloat(i) }
        let colors = locations.map { UIColor(hue: $0, saturation: s, brightness: l, alpha: a).cgColor }
        trackLayer.colors = colors
        trackLayer.locations = locations as [NSNumber]
    }
}

private class VerticallyCenteredTextLayer: CATextLayer {
    // REF: http://lists.apple.com/archives/quartz-dev/2008/Aug/msg00016.html
    // CREDIT: David Hoerl - https://github.com/dhoerl
    // USAGE: To fix the vertical alignment issue that currently exists within the CATextLayer class.

    override func draw(in ctx: CGContext) {
        let fontSize = self.fontSize
        let height = bounds.size.height
        let deltaY = (height - fontSize) / 2 - fontSize / 10

        ctx.saveGState()
        ctx.translateBy(x: 0.0, y: deltaY)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}
