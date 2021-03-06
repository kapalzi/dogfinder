//
//  LoginViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 22/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel {

    func login(username: String?, password: String?, completion: @escaping (() -> Void)) {

        guard let username = username else { return }
        guard let password = password else { return }

        self.api.login(username: username, password: password, completionHandler: completion) { (error) in
            print(error)
        }
    }
}
