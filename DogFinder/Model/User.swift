//
//  User.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 21/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {

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

    public static func fromJson(json: JSON) -> User? {

        let user = User(id: json[User.kId].string ?? "Unknown",
                        username: json[User.kUsername].string ?? "",
                        email: json[User.kEmail].string ?? "")

        return user
    }
}
