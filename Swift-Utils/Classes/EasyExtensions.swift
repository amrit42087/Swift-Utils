
//
//  Extension.swift
//  Puda
//
//  Created by AmritPal Singh on 6/22/18.
//  Copyright © 2018 AmritPal Singh. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

struct StopWatch {
    
    var totalSeconds: Int
    
    var years: Int {
        return totalSeconds / 31536000
    }
    
    var days: Int {
        return (totalSeconds % 31536000) / 86400
    }
    
    var hours: Int {
        return (totalSeconds % 86400) / 3600
    }
    
    var minutes: Int {
        return (totalSeconds % 3600) / 60
    }
    
    var seconds: Int {
        return totalSeconds % 60
    }
    
    //simplified to what OP wanted
    var hoursMinutesAndSeconds: (hours: Int, minutes: Int, seconds: Int) {
        return (hours, minutes, seconds)
    }
}

// Round off double value to two decimal places
extension Double {
    func roundValue() -> String {
        return String(format: "%.2f", self)
    }
}

// UIApplication extension

extension UIApplication {
    
    // Get the status bar to change the background color
    var statusBar: UIView? {
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            return statusBar
        }
        
        return nil
    }
    
}
