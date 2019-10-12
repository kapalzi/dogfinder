//
//  LoginViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 22/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    private let viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginDidTap(_ sender: UIButton) {
        
        self.viewModel.login(username: self.usernameTextField.text, password: self.passwordTextField.text) {
            
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
