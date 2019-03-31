
//
//  Extensions+UIView.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/5/19.
//

import Foundation

extension UIView {
    
    // Remove all contraints from a view 
    public func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
    
    // This is an extension to get the UIView from an XIB
    // If an XIB contains multiple UIViews, then an index can be passed to fetch the desired XIB
    public class func viewFromNib(name: String, index: Int = 0) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return views?[index] as? UIView
    }
    
    // Add loader to the view
    // If self = UIButton, the title will be removed and loader will be added to the center of the button. Title will be set again once the loading is completed
    public func lock(text: String? = nil,
                     tintColor: UIColor? = nil,
                     textColor: UIColor? = nil,
                     font: UIFont? = nil,
                     centerImage: UIImage? = nil,
                     size: CGSize? = nil ) {
        
        DispatchQueue.main.async {
            if let _ = self.viewWithTag(2001) {
                //View is already locked
            }
            else {

//                ASLoader.appearance().tintColor
                let tintColor = tintColor ?? ASLoader.appearance().tintColor
//                let textColor = textColor ?? ASLoader.appearance().textColor
//                let font = font ?? ASLoader.appearance().font
                let size = size ?? ASLoader.appearance().size

//                let tintColor = tintColor
//                let textColor = textColor
//                let font = font
//                let size = size

                let lockView = UIView(frame: self.bounds)
                lockView.backgroundColor = UIColor(white: 0, alpha: 0.3)
                
                lockView.alpha = 0.0

                let imageView = UIImageView()
                let logoImageView = UIImageView()

                imageView.frame.size.height = size.height
                imageView.frame.size.width = size.width
                logoImageView.frame.size.height = imageView.frame.width/2
                logoImageView.frame.size.width = imageView.frame.width/2

                imageView.center = lockView.center

                let bundle = Bundle(for: ASCustomizableView.self)

                let image = UIImage(named: "loading", in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
                imageView.image = image 

                imageView.tintColor = tintColor
                lockView.addSubview(imageView)
                
                lockView.tag = 2001
                logoImageView.contentMode = .scaleAspectFit
                logoImageView.center = lockView.center
                logoImageView.image = centerImage

                logoImageView.layer.cornerRadius = logoImageView.frame.width/2
                logoImageView.clipsToBounds = true
                lockView.addSubview(logoImageView)

                if let text = text {
                    let label = UILabel()
                    label.text = text
                    label.sizeToFit()
                    label.center = CGPoint(x: imageView.center.x, y: imageView.center.y + (imageView.bounds.height/2) + 15)
                    lockView.addSubview(label)
                }

                self.rotateView(view: imageView)
                
//                let activity = UIActivityIndicatorView(style: .white)
//                activity.hidesWhenStopped = true
//                activity.center = lockView.center
//                activity.startAnimating()
                self.addSubview(lockView)
                
                if let button = self as? UIButton {
                    self.topControllerInHierarchy()?.view.isUserInteractionEnabled = false
                    UserDefaults.standard.set(button.titleLabel?.text, forKey: "lockedButtonTitle")
                    button.setTitle("", for: .normal)
                }
                
                UIView.animate(withDuration: 0.2) {
                    lockView.alpha = 1.0
                }
            }
        }
        
    }
    
    func rotateView(view: UIView, duration: Double = 1) {
        
        let kRotationAnimationKey = "com.myapplication.rotationanimationkey"
        if view.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(.pi * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            view.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    
    // Remove loader from the locked view
    public func unlock() {
        DispatchQueue.main.async {
            if let lockView = self.viewWithTag(2001) {
                UIView.animate(withDuration: 0.2, animations: {
                    lockView.alpha = 0.0
                }) { finished in
                    lockView.removeFromSuperview()
                    self.topControllerInHierarchy()?.view.isUserInteractionEnabled = true
                    if let button = self as? UIButton {
                        if let title = UserDefaults.standard.object(forKey: "lockedButtonTitle") as? String {
                            button.setTitle(title, for: .normal)
                        }
                    }
                }
            }
        }
    }
    
    // Get the controller in which the view is embedded
    @objc public func parentContainerViewController() -> UIViewController? {
        
        var matchController = viewContainingController()
        var parentContainerViewController : UIViewController?
        
        if var navController = matchController?.navigationController {
            
            while let parentNav = navController.navigationController {
                navController = parentNav
            }
            
            var parentController : UIViewController = navController
            
            while let parent = parentController.parent,
                (parent.isKind(of: UINavigationController.self) == false &&
                    parent.isKind(of: UITabBarController.self) == false &&
                    parent.isKind(of: UISplitViewController.self) == false) {
                        
                        parentController = parent
            }
            
            if navController == parentController {
                parentContainerViewController = navController.topViewController
            } else {
                parentContainerViewController = parentController
            }
        }
        else if let tabController = matchController?.tabBarController {
            
            if let navController = tabController.selectedViewController as? UINavigationController {
                parentContainerViewController = navController.topViewController
            } else {
                parentContainerViewController = tabController.selectedViewController
            }
        } else {
            while let parentController = matchController?.parent,
                (parentController.isKind(of: UINavigationController.self) == false &&
                    parentController.isKind(of: UITabBarController.self) == false &&
                    parentController.isKind(of: UISplitViewController.self) == false) {
                        
                        matchController = parentController
            }
            
            parentContainerViewController = matchController
        }
        
        return parentContainerViewController
        
    }
    
}

// UIView Border and round cornering
extension UIView {
    
    public func shadowWithRoundCorner(cornerRadius: CGFloat = 10) {
        
        if accessibilityPath == nil {
            self.layoutIfNeeded()
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
            layer.shadowOpacity = 1.0
            layer.shadowPath = path.cgPath
            layer.shadowRadius = 10
            accessibilityPath = path
            layer.cornerRadius = cornerRadius
        }
        
    }
    
    /// This is an extension for creating round corners of a UIView from certain corners.
    /// You can specify the corners that needs to be rounded
    public  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.layoutIfNeeded()
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// Add a dashed border to a UIView
    public func dashedBorder(borderColor: UIColor = .black, lineDashPattern: [NSNumber] = [2,2]) {
        
        // Check is avoid adding border multiple time like in a tableview cell
        if self.accessibilityIdentifier != "borderAdded" {
            layoutIfNeeded()
            let yourViewBorder = CAShapeLayer()
            yourViewBorder.strokeColor = borderColor.cgColor
            yourViewBorder.lineDashPattern = lineDashPattern
            yourViewBorder.frame = self.bounds
            yourViewBorder.fillColor = nil
            yourViewBorder.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius).cgPath
            
            accessibilityIdentifier = "borderAddedd"
            
            layer.addSublayer(yourViewBorder)
        }
        
    }
}

public enum PopUpPosition {
    case top
    case center
    case bottom
}

// MARK: - For adding a PopUp
extension UIView {

    // Set the final frame of view with respect to the view/controller passed where the view is to be added, with an animation
    func animateWithFinalFrame(addFrom: UIRectEdge, position: PopUpPosition, withRespectTo rect: CGRect) {
        
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5  , options: .curveEaseInOut , animations: {
            if position == .center {
                if addFrom == .bottom || addFrom == .top{
                    self.center.y = rect.midY
                } else if addFrom == .left || addFrom == .right {
                    self.center.x = rect.midX
                }
            } else if position == .bottom {
                if addFrom == .bottom || addFrom == .top{
                    self.frame.origin.y = rect.height-self.frame.height
                } else if addFrom == .left || addFrom == .right {
                    self.center.x = rect.midX
                }
            } else if position == .top {
                if addFrom == .bottom || addFrom == .top {
                    self.frame.origin.y = 0
                } else if addFrom == .left || addFrom == .right {
                    self.center.x = rect.midX
                }
            }
            
        })
        
    }
    
    // Set the initioal frame of view with respect to the view/controller passed where the view is to be added
    func setInitialFrame(addFrom: UIRectEdge, position: PopUpPosition, withRespectTo rect: CGRect) {
        if position == .center {
            if addFrom == .bottom {
                center.x = rect.midX
                center.y = UIScreen.main.bounds.height
                self.accessibilityValue = "bottom"
            } else if addFrom == .left {
                center = CGPoint(x: rect.origin.x - (self.frame.width/2), y: rect.midY)
                self.accessibilityValue = "left"
            } else if addFrom == .right {
                center = CGPoint(x: rect.width+(self.frame.width/2), y: rect.midY)
                self.accessibilityValue = "right"
            } else if addFrom == .top {
                center.x = rect.midX
                center.y = -UIScreen.main.bounds.height
                self.accessibilityValue = "top"
            }
        } else if position == .bottom {
            if addFrom == .bottom {
                center.x = rect.midX
                center.y = UIScreen.main.bounds.height
                self.accessibilityValue = "bottom"
            } else if addFrom == .left {
                center = CGPoint(x: rect.origin.x - (self.frame.width/2), y: rect.height - (frame.height/2))
                self.accessibilityValue = "left"
            } else if addFrom == .right {
                center = CGPoint(x: rect.width+(self.frame.width/2), y: rect.height - (frame.height/2))
                self.accessibilityValue = "right"
            } else if addFrom == .top {
                center = CGPoint(x: rect.midX, y: -rect.height - (frame.height/2))
                self.accessibilityValue = "top"
            }
            
        } else if position == .top {
            if addFrom == .bottom {
                center.x = rect.midX
                center.y = UIScreen.main.bounds.height
                self.accessibilityValue = "bottom"
            } else if addFrom == .left {
                center = CGPoint(x: rect.origin.x - (self.frame.width/2), y: self.frame.height/2)
                self.accessibilityValue = "left"
            } else if addFrom == .right {
                center = CGPoint(x: rect.width+(self.frame.width/2), y: self.frame.height/2)
                self.accessibilityValue = "right"
            } else if addFrom == .top {
                center = CGPoint(x: rect.midX, y: -frame.height)
                self.accessibilityValue = "top"
            }
        }
    }
    
    // Add any view as a pop up in either a controller or the UIWindow
    // If a controller is not passed, pop up will be added to the UIWindow
    public func addIn(_ controller: UIViewController? = nil, backGroundColor: UIColor = .black, addFrom: UIRectEdge, position: PopUpPosition) {
        
        let parentMainView = controller?.view ?? UIApplication.shared.keyWindow
        
        guard let parentView = parentMainView else { return }
        
        let blackView = UIView()
        blackView.frame = UIScreen.main.bounds
        blackView.backgroundColor = backGroundColor.withAlphaComponent(0.0)
        blackView.tag = 3004
        
        setInitialFrame(addFrom: addFrom, position: position, withRespectTo: parentView.bounds)
        
        tag = 3003
        
        blackView.addSubview(self)
        parentView.addSubview(blackView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedBlackView(_:)))
        tapGesture.cancelsTouchesInView = false
        blackView.addGestureRecognizer(tapGesture)
        
        animateWithFinalFrame(addFrom: addFrom, position: position, withRespectTo: parentView.bounds)
        
        UIView.animate(withDuration: 0.5, animations: {
            blackView.backgroundColor = backGroundColor.withAlphaComponent(0.8)
        })
        
    }
    
    // This function is used to remove the pop up from the parent view
    // User can also remove the pop up by tapping anywhere outside the popup
    // Pop will be remove in the same animation as it was added
    public func removeView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.superview?.backgroundColor = UIColor(white: 0, alpha: 0.0)
            
            if let accessibiltyHint = self.accessibilityValue {
                if accessibiltyHint == "bottom" {
                    self.frame.origin.y = UIScreen.main.bounds.height
                } else if accessibiltyHint == "left" {
                    self.frame.origin.x = -UIScreen.main.bounds.width
                } else if accessibiltyHint == "top" {
                    self.frame.origin.y = -UIScreen.main.bounds.height
                } else {
                    self.frame.origin.x = UIScreen.main.bounds.width
                }
            }
            
        }) { (success) in
            self.superview?.removeFromSuperview()
        }
    }
    
    @objc func tappedBlackView(_ sender: UITapGestureRecognizer) {
        
        let point = sender.location(in: sender.view)
        let touchedView = sender.view?.hitTest(point, with: nil)
        
        if touchedView?.tag == 3004 {
            UIView.animate(withDuration: 0.3, animations: {
                sender.view?.backgroundColor = UIColor(white: 0, alpha: 0.0)
                if let view = sender.view?.viewWithTag(3003) {
                    
                    if let accessibiltyHint = view.accessibilityValue {
                        if accessibiltyHint == "bottom" {
                            view.frame.origin.y = UIScreen.main.bounds.height
                        } else if accessibiltyHint == "left" {
                            view.frame.origin.x = -UIScreen.main.bounds.width
                        } else if accessibiltyHint == "top" {
                            view.frame.origin.y = -UIScreen.main.bounds.height
                        } else {
                            view.frame.origin.x = UIScreen.main.bounds.width
                        }
                    }
                    
                }
            }) { (success) in
                sender.view?.removeFromSuperview()
            }
        }
        
    }

    // This function adds a blur view at zero index.
    public func addBlurView(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurEffectView, at: 0)
    }
}
