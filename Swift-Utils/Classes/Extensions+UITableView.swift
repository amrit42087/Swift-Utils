
//
//  Extensions+UITableView.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/5/19.
//

import Foundation

extension UITableView {
    public func indexPath(for view: UIView) -> IndexPath? {
        let location = view.convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: location)
    }
    
    public func handleEmptyTable(text: String?) {
        
        if text == nil {
            self.backgroundView = nil
        } else {
            let backGroundView = UIView()
            
            let noDataLbl = UILabel()
            noDataLbl.frame = CGRect(x: 10, y: 20, width: self.bounds.width - 20, height: self.bounds.height)
            noDataLbl.textAlignment = .center
            noDataLbl.textColor = UIColor.black
            noDataLbl.text = text
            noDataLbl.numberOfLines = 0
            
            backGroundView.addSubview(noDataLbl)
            self.backgroundView = backGroundView
            
        }
    }
}
