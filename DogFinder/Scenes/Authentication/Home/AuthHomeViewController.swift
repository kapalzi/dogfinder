//
//  AuthHomeViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 12/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class AuthHomeViewController: UIViewController {
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signupBtn: UIButton!
    
    override func viewDidLoad() {
        
        self.loginBtn.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.signupBtn.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
    }
}
