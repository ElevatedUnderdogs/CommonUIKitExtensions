//
//  UIButton.swift
//  akin
//
//  Created by Scott Lydon on 8/1/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import UIKit


public extension UIButton {
    
    // MARK - set color
    
    func set(color: UIColor) {
        let img = imageView?.image?.withRenderingMode(.alwaysTemplate)
        setImage(img, for: .normal)
        tintColor = color
    }
    
    // MARK - set image
    
    func safelySetImage(_ image: UIImage?, for state: UIControl.State = .normal) {
        DispatchQueue.main.async {
            self.setImage(image, for: state)
        }
    }
    
    func downloadImageFrom(link: String)  {
        guard let nsurl = NSURL(string:link) else {
//            URL.assert(message: "\(#line) \(#file)").ping()
            return
        }
        URLSession.shared.dataTask( with: nsurl as URL, completionHandler: {
            data, response, error in
            if let err = error {
                print("Error: ", err, Date())
            }
            DispatchQueue.main.async {
                guard error == nil else { return }
                self.setImage(nil, for: .normal)
                self.contentMode = .scaleAspectFill
                if let data = data {
                    self.setImage(UIImage(data: data), for: .normal)
                }
            }
        }).resume()
    }
    
//    func round(side: Side, constant: CGFloat = 5) {
//        let path = UIBezierPath(
//            roundedRect: bounds,
//            byRoundingCorners: side == .left ? [
//                .topLeft,
//                .bottomLeft
//                ] : [
//                    .topRight,
//                    .bottomRight
//            ],
//            cornerRadii: CGSize(width: constant, height: constant)
//        )
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        layer.mask = maskLayer
//    }
    
//    func setCircleView( _ img: UIImage, inset: CGFloat) {
//        backgroundColor = UIColor.white.withAlphaComponent(0.5)
//        makeCircularClipsMask()
//        layer.applySketchShadow()
//        let img = img.withRenderingMode(.alwaysTemplate)
//        setImage(img, for: .normal)
//        tintColor = .white
//        imageEdgeInsets = UIEdgeInsets(
//            top: inset,
//            left: inset,
//            bottom: inset,
//            right: inset
//        )
//    }
    
    // MARK - init
    
//    convenience init(_ model: Model) {
//        self.init()
//        accessibilityIdentifier = model.accessibilityID
//        backgroundColor = model.color
//        setTitleColor(model.textColor, for: .normal)
//        setTitle(model.text)
//        titleLabel?.set(font: .akin)
//    }
    
    // MARK - style
    
    
    func glow(with color: UIColor) {
        layer.backgroundColor = color.cgColor
        layer.applySketchShadow(color: color, alpha: 0.7, y: 3)
    }
    
    
    // MARK - set title

    func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
    }

    func setImportanceColor(selected: Bool = true, withColor color: UIColor) {
        backgroundColor = color
    }
    
    
//    func style(with choice: Question.Response.Selections.MyTheir.Choice) {
//        backgroundColor = choice.backgroundColor
//        layer.applySketchShadow(color: choice.glowColor, alpha: 0.56)
//        setTitle(choice.rawValue, for: .normal)
//    }
//
//    func styleAsTile(static staticImportance: Question.Importance, importance: Question.Importance?, color: UIColor) {
//        if let importance = importance,  importance.rawValue >= staticImportance.rawValue {
//            backgroundColor = color
//        } else {
//            backgroundColor = .white
//        }
//    }
}


public extension CALayer {

    func applySketchShadow(
        color: UIColor? = .black,
        alpha: Float = 0.16,
        x: CGFloat = 0,
        y: CGFloat = 3,
        blur: CGFloat = 6,
        spread: CGFloat = 0,
        applyBezier: Bool = true
        ) {

        masksToBounds = false
        shadowColor = color?.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == -1 { return }
        guard applyBezier else { return }
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

