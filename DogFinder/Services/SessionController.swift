//
//  SessionController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 12/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class SessionController {

    public static let sharedInstance = SessionController()
    public var token: String! = "" {
        didSet {
            UserDefaults.standard.set(self.token, forKey: "token")
        }
    }
    public var currentUser: User! {
        didSet {
            guard let user = self.currentUser else { return }
            UserDefaults.standard.set(user._id, forKey: "userId")
            UserDefaults.standard.set(user.username, forKey: "userName")
            UserDefaults.standard.set(user.email, forKey: "email")
        }
    }

    func isUserLoggedIn() -> Bool {

        guard let token = UserDefaults.standard.string(forKey: "token") else { return false }
        self.token = token

        guard let id = UserDefaults.standard.string(forKey: "userId") else { return false }
        guard let userName = UserDefaults.standard.string(forKey: "userName") else { return false }
        guard let email = UserDefaults.standard.string(forKey: "email") else { return false }
        self.currentUser = User(id: id, username: userName, email: email)

        return true
    }

    func logout() {

        self.currentUser = nil
        self.token = nil
        UserDefaults.standard.set(nil, forKey: "token")
        UserDefaults.standard.set(nil, forKey: "userId")
        UserDefaults.standard.set(nil, forKey: "userName")
        UserDefaults.standard.set(nil, forKey: "email")
    }

}
