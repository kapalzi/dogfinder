//
//  LoginViewModelTests.swift
//  DogFinderTests
//
//  Created by Krzysztof Kapała on 09/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import XCTest
@testable import DogFinder

class LoginViewModelTests: XCTestCase {
    
    var loginViewModel: LoginViewModel!
    
    override func setUp() {
        
        self.loginViewModel = LoginViewModel(api: MockDogFinderApi.sharedInstance)
        SessionController.sharedInstance.token = nil
    }
    
    override func tearDown() {
        
        SessionController.sharedInstance.token = nil
    }
    
    func testLogin() {
        
        self.loginViewModel.login(username: "user", password: "password") {
            XCTAssert(SessionController.sharedInstance.token == "token")
        }
    }
}
