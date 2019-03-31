//
//  Extensions+UITextfeild.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/31/19.
//

import UIKit

extension UITextField {
    func setPlaceholder(text: String?, color: UIColor = UIColor(white: 0.7, alpha: 1.0)) {
        self.attributedPlaceholder = NSAttributedString(string: text ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
