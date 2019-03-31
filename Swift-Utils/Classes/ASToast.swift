//
//  ASToast.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/26/19.
//

open class ASToast: UIView {

    @objc dynamic public var toastBackgroundColor: UIColor? = .red
    @objc dynamic open var textColor: UIColor? = .black
    @objc dynamic open var font: UIFont?
    @objc dynamic open var isBlurred: Bool = false

    static var textColor: UIColor? {
        return ASToast.appearance().textColor
    }

    static var toastBackgroundColor: UIColor? {
        return ASToast.appearance().toastBackgroundColor
    }

    static var font: UIFont? {
        return ASToast.appearance().font
    }

    static var isBlurred: Bool {
        return ASToast.appearance().isBlurred
    }

}

