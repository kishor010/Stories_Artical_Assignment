//
//  DateHelper.swift
//  Assignment
//
//  Created by Kishor Pahalwani on 16/02/20.
//  Copyright © 2020 Kishor Pahalwani. All rights reserved.
//

import Foundation

class DateHelper {
    static func convertUnixTime(time: TimeInterval) -> String? {
        let date = Date(timeIntervalSince1970: time)
        
        let calendar = Calendar.current
        
        let difference = calendar.dateComponents([.day,.hour, .minute,.second], from: date, to: Date())
        
        if let day = difference.day, day != 0 {
            return String(day) + "d"
        }
        
        else if let hours = difference.hour, hours != 0 {
            return String(hours) + "h"
        }
            
        else if let mins = difference.minute, mins != 0 {
            return String(mins) + "m"
        }
        
        else if let sec = difference.second, sec != 0 {
            return String(sec) + "s"
        }
        
        return nil
    }
}
