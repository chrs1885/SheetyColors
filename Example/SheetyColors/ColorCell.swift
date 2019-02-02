import UIKit

class ColorCell: UICollectionViewCell {
    var colorLayer: CALayer!
    var transparencyPatternLayer: CALayer!

    var color: UIColor = .clear {
        didSet {
            colorLayer?.backgroundColor = color.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupColorView()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupColorView() {
        transparencyPatternLayer = CALayer()
        let bundle = Bundle(for: ColorCell.self)
        if let transparencyIcon = UIImage(named: "Transparency", in: bundle, compatibleWith: nil) {
            transparencyPatternLayer.backgroundColor = UIColor(patternImage: transparencyIcon).cgColor
        }
        layer.addSublayer(transparencyPatternLayer)

        colorLayer = CALayer()
        layer.addSublayer(colorLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        colorLayer.frame = bounds
        transparencyPatternLayer.frame = bounds
    }
}
