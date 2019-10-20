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
    public class func dateFromJs(_ date2:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: date2) {
            print(date)  // "2015-05-15 21:58:00 +0000"
            return date
        }
        
        return nil
    }
}
