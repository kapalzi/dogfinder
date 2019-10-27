//
//  Date+Extension.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 27/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

extension Date {
    func toString( dateFormat format: String = "dd.MM.YYYY HH:mm" ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
