//
//  RegisterViewModel.swift
//  DogFinderTests
//
//  Created by Krzysztof Kapała on 09/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import XCTest
@testable import DogFinder

class RegisterViewModelTests: XCTestCase {
    
    let registerViewModel: RegisterViewModel = RegisterViewModel(api: MockDogFinderApi.sharedInstance)
    
    override func setUp() {
        
        SessionController.sharedInstance.token = nil
    }
    
    override func tearDown() {
        
        SessionController.sharedInstance.token = nil
    }
    
    func testRegister() {
        
        self.registerViewModel.register(username: "user", password: "password", email: "email") {
            XCTAssert(SessionController.sharedInstance.token == "token")
        }
    }
}
