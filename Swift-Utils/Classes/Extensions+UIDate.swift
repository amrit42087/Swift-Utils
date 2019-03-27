//
//  Extensions+UIDate.swift
//  Pods-Swift-Utils_Example
//
//  Created by Amritpal Singh on 3/5/19.
//

import Foundation

public extension Date {
    
    public func isGreaterThanDate(date: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    public func isLessThanDate(date: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    public func isEqualToDate(date: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(date) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    public func toDateString(format: String = "yyyy-MM-dd",
                             timezone: TimeZone? = TimeZone(identifier: "UTC")) -> String {
        
        let timezone =  TimeZone(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timezone
        let str = formatter.string(from: self as Date)
        return str
    }
    
    
    public func timeAgoValue(_ numericDates:Bool = false) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        
        let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        
        if (components.year! >= 2) {
            
            return "\(components.year!) years ago"
            
        } else if (components.year! >= 1) {
            
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
            
        } else if (components.month! >= 2) {
            
            return "\(components.month!) months ago"
            
        } else if (components.month! >= 1) {
            
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
            
        } else if (components.weekOfYear! >= 2) {
            
            return "\(components.weekOfYear!) weeks ago"
            
        } else if (components.weekOfYear! >= 1) {
            
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
            
        } else if (components.day! >= 2) {
            
            return "\(components.day!) days ago"
            
        } else if (components.day! >= 1){
            
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
            
        } else if (components.hour! >= 1) {
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
}
