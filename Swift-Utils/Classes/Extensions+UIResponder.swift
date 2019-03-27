
//
//  Extensions+UIResponder.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/5/19.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

extension UIResponder {
    
    public func showToast(message: String,
                          backgroundColor: UIColor? = nil,
                          textColor: UIColor? = nil,
                          font: UIFont? = nil) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        
        if let view = window.viewWithTag(2005) {
            //already present
            if let label = view.viewWithTag(2002) as? UILabel {
                label.text = message
            }
            
        } else {
            
            let backgroundColor = backgroundColor ?? ASToast.toastBackgroundColor
            let textColor = textColor ?? ASToast.textColor
            let font = font ?? ASToast.font

//            let backgroundColor = backgroundColor
//            let textColor = textColor
//            let font = font

            let height = getHeight(text: message, toFitFixedWidth: window.frame.width-40, font: UIFont.systemFont(ofSize: 12.0))
            
            let lockView = UIView()
            lockView.frame = CGRect(x: 10, y: (window.frame.height) , width: window.frame.width-20, height: height+50)
            
            lockView.backgroundColor = backgroundColor
            lockView.layer.cornerRadius = 5
            lockView.clipsToBounds = true
            lockView.alpha = 0.0
            lockView.tag = 2005
            
            let label = UILabel()
            label.frame = CGRect(x: 10, y: 5, width: lockView.frame.width-20, height: lockView.frame.height-10)
            label.text = message
            label.numberOfLines = 0
            label.textColor = textColor
            label.textAlignment = .center
            label.font = font
            label.tag = 2002
            label.sizeToFit()
            
            let actualWidth = label.frame.width+20
            label.frame = CGRect(x: 10, y: 5, width: actualWidth-20, height: lockView.frame.height-10)
            
            let info = ["view" : lockView]
            _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(hideToast), userInfo: info, repeats: false)
            
            lockView.addSubview(label)
            window.addSubview(lockView)
            
            let tabBarHeight : CGFloat = 0.0
            
            lockView.frame = CGRect(x: 10, y: ((window.frame.height)-tabBarHeight) - (height+60), width: actualWidth, height: height+50)
            lockView.center.x = window.center.x
            
            //            if self.tabBarController != nil {
            //                tabBarHeight = 60
            //            }
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
                lockView.center.y = ((window.frame.height)-tabBarHeight) - (height+60)
                //                    CGRect(x: 10, y: ((window.frame.height)-tabBarHeight) - (height+60), width: actualWidth, height: height+50)
                
            }
        }
        
    }
    
    @objc func hideToast(timer: Timer){
        
        if let info = timer.userInfo as? NSDictionary {
            let view = (info).object(forKey: "view") as? UIView
            
            let window = UIApplication.shared.keyWindow
            
            if view?.tag == 2005 {
                UIView.animate(withDuration: 0.2, animations: {
                    view?.frame = CGRect(x: 10, y: (window!.frame.height), width: window!.frame.width-20, height: 50)
                }, completion: { (success) in
                    view?.removeFromSuperview()
                })
            }
        }
        
    }
    
    // Get height of the text
    func getHeight(text:String, toFitFixedWidth fixedWidth: CGFloat, font : UIFont) -> CGFloat{
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.frame = CGRect(x: 0, y: 0, width: fixedWidth, height: 0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label.frame.height
    }
    
    @objc public func topControllerInHierarchy() -> UIViewController? {
        
        guard let window = UIApplication.shared.keyWindow else { return nil }
        var controllersHierarchy = [UIViewController]()
        
        if var topController = window.rootViewController {
            controllersHierarchy.append(topController)
            
            while let presented = topController.presentedViewController {
                topController = presented
                controllersHierarchy.append(presented)
            }
            
            var matchController :UIResponder? = viewContainingController()
            
            while matchController != nil && controllersHierarchy.contains(matchController as! UIViewController) == false {
                
                repeat {
                    matchController = matchController?.next
                } while matchController != nil && matchController is UIViewController == false
            }
            
            return matchController as? UIViewController
            
        } else {
            return viewContainingController()
        }
    }
    
    /**
     Returns the UIViewController object that manages the receiver.
     */
    @objc public func viewContainingController()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
    
}
