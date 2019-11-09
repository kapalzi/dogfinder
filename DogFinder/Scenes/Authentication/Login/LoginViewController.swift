//
//  LoginViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 22/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginBtn: UIButton!

    private let viewModel: LoginViewModel = LoginViewModel(api: DogFinderApi.sharedInstance)

    override func viewDidLoad() {

        super.viewDidLoad()
        self.initControls()
    }

    private func initControls() {

        self.usernameTextField.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.passwordTextField.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.loginBtn.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))

        let attributedString = NSAttributedString(string: "Placeholder Text",
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 96, green: 90, blue: 76, alpha: 1),
                                                               NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 12)!])
        self.usernameTextField.attributedPlaceholder = attributedString
        self.passwordTextField.attributedPlaceholder = attributedString

        self.usernameTextField.placeholder = "Your username..."
        self.passwordTextField.placeholder = "Password..."
    }

    @IBAction func loginDidTap(_ sender: UIButton) {

        self.viewModel.login(username: self.usernameTextField.text, password: self.passwordTextField.text) {

            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

}
