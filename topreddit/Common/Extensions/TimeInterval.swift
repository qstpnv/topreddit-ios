//
//  TimeInterval.swift
//  topreddit
//
//  Created by Arthur Stepanov on 04.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    // Converting TimeInterval (timestamp) to String with format like 'x hours ago'
    func toPrettyDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " year ago" : "\(year)" + " years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " month ago" : "\(month)" + " months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " day ago" : "\(day)" + " days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " hour ago" : "\(hour)" + " hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " minute ago" : "\(minute)" + " minutes ago"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " second ago" : "\(second)" + " seconds ago"
        } else {
            return "a moment ago"
        }
    }
    
}
