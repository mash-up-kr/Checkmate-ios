import UIKit

@IBDesignable
open class GraphicView: UIView {
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable open var shadowColor: UIColor? {
        didSet {
            self.layer.shadowColor = shadowColor?.cgColor
        }
    }
    
    @IBInspectable open var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable open var shadowOffset: CGSize = CGSize.zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable open var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable open var masksToBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = masksToBounds
        }
    }
}

@IBDesignable
open class GraphicLabel: UILabel {
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
}

@IBDesignable
open class GraphicButton: UIButton {
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
}

@IBDesignable
open class OnOffButton: GraphicButton {
    @IBInspectable open var onBackgroundColor: UIColor? { didSet { updateUI() } }
    @IBInspectable open var onTitleColor: UIColor? { didSet { updateUI() } }
    @IBInspectable open var offBackgroundColor: UIColor? { didSet { updateUI() } }
    @IBInspectable open var offTitleColor: UIColor? { didSet { updateUI() } }
    @IBInspectable open var isOn: Bool = false { didSet { updateUI() } }
    
    var _onBackgroundColor: UIColor?
    var _onTitleColor: UIColor?
    var _offBackgroundColor: UIColor?
    var _offTitleColor: UIColor?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        self.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
    }

    @IBAction func btnClicked() {
        isOn = !isOn
        updateUI()
    }
    
    private func updateUI() {
        backgroundColor = isOn ? onBackgroundColor : offBackgroundColor
        setTitleColor(isOn ? onTitleColor : offTitleColor, for: .normal)
    }
}
