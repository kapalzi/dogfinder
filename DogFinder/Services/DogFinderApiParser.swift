//
//  DogFinderApiParser.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 30/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import Alamofire

class DogFinderApiParser {

    public class func parseJsonWithDogs(_ payload: Data, completionHandler:@escaping ((_:[Dog]) -> Void)) {

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
        do {
            let dogs = try decoder.decode([Dog].self, from: payload)
            DispatchQueue.main.async {
                completionHandler(dogs)
                return
            }
        } catch let error {
            print(error)
        }
    }

    public class func parseJsonWithUser(_ payload: Data, completionHandler:@escaping ((_:User) -> Void)) {

        do {
            let user = try JSONDecoder().decode(User.self, from: payload)
            completionHandler(user)
        } catch let error {
            print(error)
        }
    }
}

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}
