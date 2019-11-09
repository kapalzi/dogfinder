//
//  RegisterViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 12/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class RegisterViewModel: BaseViewModel {

    func register(username: String?, password: String?, email: String?, completion: @escaping (() -> Void)) {

        guard let username = username else { return }
        guard let password = password else { return }
        guard let email = email else { return }

        self.api.register(username: username, password: password, email: email, completionHandler: completion) { (error) in
            print(error)
        }
    }
}
