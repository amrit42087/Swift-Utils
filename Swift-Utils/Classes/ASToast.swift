//
//  ASToast.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/26/19.
//

open class ASToast: UIView {

    @objc dynamic open var toastBackgroundColor: UIColor? = .red
    @objc dynamic open var textColor: UIColor? = .black
    @objc dynamic open var font: UIFont? = UIFont.systemFont(ofSize: 12.0)

    static var textColor: UIColor? {
        return ASToast.appearance().textColor
    }

    static var toastBackgroundColor: UIColor? {
        return ASToast.appearance().textColor
    }

    static var font: UIFont? {
        return ASToast.appearance().font
    }

}

