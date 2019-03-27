//
//  Extensions+UITableViewCell.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/5/19.
//

import Foundation

extension UITableViewCell {
    //    var tableView: UITableView? {
    //        return self.parentView(of: UITableView.self)
    //    }
    
    public var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    public var indexPathOfCell: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}
