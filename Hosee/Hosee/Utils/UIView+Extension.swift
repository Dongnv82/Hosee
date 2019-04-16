//
//  CustomRadiusAndBoder.swift
//  BookCancleDemo
//
//  Created by apple on 20/03/2019.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

import UIKit


@IBDesignable
class ImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0
    override func layoutSubviews() {
        super.layoutSubviews()
        rounderCorner(radius: cornerRadius)
    }
}

@IBDesignable
class View: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var topBorder: Bool = false
    @IBInspectable var leftBorder: Bool = false
    @IBInspectable var rightBorder: Bool = false
    @IBInspectable var bottomBorder: Bool = false
    override func layoutSubviews() {
        super.layoutSubviews()
        rounderCorner(radius: cornerRadius)
        if topBorder {
            addBorder(layerNameKey: LayerNameKey.topBorder, color: borderColor)
        }
        if leftBorder {
            addBorder(layerNameKey: LayerNameKey.leftBorder, color: borderColor)
        }
        if rightBorder {
            addBorder(layerNameKey: LayerNameKey.rightBorder, color: borderColor)
        }
        if bottomBorder {
            addBorder(layerNameKey: LayerNameKey.bottomBorder, color: borderColor)
        }
    }
}

@IBDesignable
class Button: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0
    override func layoutSubviews() {
        super.layoutSubviews()
        rounderCorner(radius: cornerRadius)
    }
}
@IBDesignable
class Label: UILabel {
    @IBInspectable var cornerRadius: CGFloat = 0
    override func layoutSubviews() {
        super.layoutSubviews()
        rounderCorner(radius: cornerRadius)
    }
}

// MARK: - Height for View with text

extension UIView {
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}

// MARK: - Load Nib
extension UIView {
    static func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String(describing: viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    static func loadNib() -> Self {
        return loadNib(self)
    }
}


// MARK: - Attribute
extension UIView {
    
    func rounderCorner(radius: CGFloat) {
        if radius == -1 {
            layer.cornerRadius = frame.width < frame.height ? frame.width * 0.5 : frame.height * 0.5
        } else {
            layer.cornerRadius = radius
        }
        contentMode = .scaleToFill
        layer.masksToBounds = true
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

// MARK: - Animation
extension UIView {
    func animate(animations: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.transform = CATransform3DMakeScale(1.25, 1.25, 1);
        }, completion: { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }, completion: { (completed) in
                animations(completed)
            })
        })
        
    }
    func animateToSmaller(animations: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.transform = CATransform3DMakeScale(0.75, 0.75, 1);
        }, completion: { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }, completion: { (completed) in
                animations(completed)
            })
        })
        
    }
    func rotate(angle: CGFloat) {
        //        let radians = angle / 180.0 * CGFloat(Double.pi)
        let rotation = transform.rotated(by: angle)
        transform = rotation
    }
    
    func roundAndRound(duration: CFTimeInterval = 5.0) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    func shake() {
        backgroundColor = UIColor.orange.withAlphaComponent(0.2)
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 1.2
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

// MARK: - Border 4 edges

enum LayerNameKey : String {
    case topBorder = "top-border"
    case bottomBorder = "bottom-border"
    case leftBorder = "left-border"
    case rightBorder = "right-boder"
    
    func getRect(with layer: CALayer, lineWeight: CGFloat) -> CGRect {
        switch self {
        case .topBorder:
           return  CGRect(x: 0, y: 0, width: layer.frame.width, height: lineWeight)
        case .bottomBorder:
            return CGRect(x: 0, y: layer.frame.height - lineWeight, width: layer.frame.width, height: lineWeight)
        case .leftBorder:
            return CGRect(x: 0, y: 0, width: lineWeight, height: layer.frame.height)
        case .rightBorder:
            return CGRect(x: layer.frame.width - lineWeight, y: 0, width: lineWeight, height: layer.frame.height)
        }
    }
}


extension UIView {
    func addBorder(layerNameKey: LayerNameKey, color: UIColor? = nil) {
            // add top border
        let border = UIView(frame: layerNameKey.getRect(with: layer, lineWeight: borderWidth))
            border.layer.name = layerNameKey.rawValue
            border.backgroundColor = color ?? UIColor.groupTableViewBackground
            layer.setValue(border, forKey: layerNameKey.rawValue)
            addSubview(border)
    }

    func removeBorderLayer(layerNameKey: LayerNameKey) {
        if let border = layer.value(forKey: layerNameKey.rawValue) as? UIView {
            border.removeFromSuperview()
            layer.setValue(nil, forKey: layerNameKey.rawValue)
        }
    }
}

// MARK: - Constraint

extension UIView {
    
    func fill(left: CGFloat? = 0, top: CGFloat? = 0, right: CGFloat? = 0, bottom: CGFloat? = 0) {
        guard let superview = superview else {
            print("\(self.description): there is no superView")
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        if let left = left {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
        }
        if let top = top  {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        }
        
        if let right = right {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension String {
    var toDate: Date {
        get {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormater.locale = Locale(identifier: "vi_VN")
            let date = dateFormater.date(from: self)
            return date!
        }
    }
}
