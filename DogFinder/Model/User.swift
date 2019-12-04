//
//  User.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 21/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject, NSCoding {

    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "_id") as! String
        self.username = coder.decodeObject(forKey: "username") as! String
        self.email = coder.decodeObject(forKey: "email") as! String
    }

    static let kId = "_id"
    static let kUsername = "username"
    static let kEmail = "email"

    let id: String
    let username: String
    let email: String

    init(id: String, username: String, email: String) {

        self.id = id
        self.username = username
        self.email = email
    }

    func encode(with coder: NSCoder) {

        coder.encode(id, forKey: "_id")
        coder.encode(username, forKey: "username")
        coder.encode(email, forKey: "email")
    }

    public static func fromJson(json: JSON) -> User? {

        let user = User(id: json[User.kId].string ?? "Unknown",
                        username: json[User.kUsername].string ?? "",
                        email: json[User.kEmail].string ?? "")

        return user
    }
}
