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
    public var token: String! = ""
    public var currentUser: User!
    
}
