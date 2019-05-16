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
    @objc dynamic open var blurStyle: UIBlurEffect.Style = .dark

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

    static var blurStyle: UIBlurEffect.Style {
        return ASToast.appearance().blurStyle
    }

    public static let shared = ASToast()
    var keyboardHeight: CGFloat = 0.0

    // Start this listener if you want to present the toast above the keyboard.
    public func startKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(didShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func didShow(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]

        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        keyboardHeight = keyboardScreenEndFrame.size.height
    }

    @objc func didHide(){
        keyboardHeight = 0
    }

}

