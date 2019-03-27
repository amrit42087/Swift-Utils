//
//  Extensions+UIViewController.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/5/19.
//

import Foundation

extension UIViewController {
    
    public func hideBackButtonTitle() {
        self.navigationController?.navigationBar.topItem?.title = " "
    }
    
    public func removeBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    public func setCustomBackButton(image: UIImage? = UIImage(named: "back")) {
        //Initialising "back button"
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(image, for: UIControl.State.normal)
        btnLeftMenu.addTarget(self, action: #selector(onClickBack), for: UIControl.Event.touchUpInside)
        btnLeftMenu.frame = CGRect(x:0, y:0, width:44, height:44)
        btnLeftMenu.imageEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0);
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    @objc func onClickBack() {
        if (self.navigationController?.viewControllers.count)! > 1 {
            _ = self.navigationController?.popViewController(animated: true)
        }else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // Show an alert
    public func showAlert(title: String?, message: String?, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let okayBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okayBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
}
