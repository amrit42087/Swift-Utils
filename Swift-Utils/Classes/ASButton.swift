//
//  ASButton.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/21/19.
//

import UIKit

@IBDesignable public class ASButton: UIButton {

    private var shadowLayer: CAShapeLayer!
    @IBInspectable var showShadow: Bool = true
    @IBInspectable var shadowRadius: CGFloat = 10
    @IBInspectable var borderWidth: CGFloat = 10
    @IBInspectable var borderColor: UIColor = .clear
    @IBInspectable var shadowOpacity: Float = 1
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOffset: CGSize = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))

    override open func layoutSubviews() {
        super.layoutSubviews()

        addShadowWithRoundCorners()
    }

    func addShadowWithRoundCorners() {
        if shadowLayer == nil {

            self.layer.cornerRadius = cornerRadius

            if showShadow == true {
                shadowLayer = CAShapeLayer()
                let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath

                layer.masksToBounds = false
                layer.shadowColor = shadowColor.cgColor
                layer.shadowOffset = shadowOffset
                layer.shadowOpacity = shadowOpacity
                layer.shadowRadius = shadowRadius
                layer.cornerRadius = cornerRadius
                layer.shadowPath = path

            }

            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth

        }

    }
}
