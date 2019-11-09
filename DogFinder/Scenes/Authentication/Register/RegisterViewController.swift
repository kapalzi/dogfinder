//
//  RegisterViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 12/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signupBtn: UIButton!

    private let viewModel: RegisterViewModel = RegisterViewModel(api: DogFinderApi.sharedInstance)

    override func viewDidLoad() {

        super.viewDidLoad()
        self.initControls()
    }

    private func initControls() {

        self.emailTextField.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.usernameTextField.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.passwordTextField.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.signupBtn.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))

        let attributedString = NSAttributedString(string: "Placeholder Text",
                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 96, green: 90, blue: 76, alpha: 1),
                                                               NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 12)!])

        self.emailTextField.attributedPlaceholder = attributedString
        self.usernameTextField.attributedPlaceholder = attributedString
        self.passwordTextField.attributedPlaceholder = attributedString

        self.emailTextField.placeholder = "Your email..."
        self.usernameTextField.placeholder = "Your username..."
        self.passwordTextField.placeholder = "Password..."
    }

    @IBAction func registerDidTap(_ sender: UIButton) {

        self.viewModel.register(username: self.usernameTextField.text, password: self.passwordTextField.text, email: self.emailTextField.text) {

            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

}
