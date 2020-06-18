//
//  User.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 21/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class User: NSObject, Codable {

    let _id: String
    let username: String
    let email: String

    init(id: String, username: String, email: String) {

        self._id = id
        self.username = username
        self.email = email
    }
}
