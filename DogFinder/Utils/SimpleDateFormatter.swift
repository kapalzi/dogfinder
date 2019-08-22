//
//  SimpleDateFormatter.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 07/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class SimpleDateFormatter: NSObject
{
    public class func unixIntvalAsStringFromDate(_ date:Date) -> String
    {
        return String(format:"%.0f",date.timeIntervalSince1970)
    }
    
    public class func dateFromUnixInterval(_ interval:Double) -> Date
    {
        return Date(timeIntervalSince1970: interval)
    }
    
    public class func dateAndTimeStringFromDate(_ date:Date?) -> String
    {
        guard let validDate = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: validDate)
    }
}
