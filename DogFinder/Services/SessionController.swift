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
            do {
               let encodedData = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
                UserDefaults.standard.set(encodedData, forKey: "user")
            } catch let error {
                print(error)
            }
        }
    }

    func isUserLoggedIn() -> Bool {

        self.token = UserDefaults.standard.string(forKey: "token")
        if let data = UserDefaults.standard.data(forKey: "user") {

            do {
                self.currentUser = try NSKeyedUnarchiver.unarchivedObject(ofClass: User.self, from: data)
            } catch let error {
                print(error)
            }

        }

        if self.currentUser == nil || self.token == nil {
            return false
        } else {
            return true
        }
    }

    func logout() {

        self.currentUser = nil
        self.token = nil
        UserDefaults.standard.set(nil, forKey: "token")
        UserDefaults.standard.set(nil, forKey: "user")
    }

}
