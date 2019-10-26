//
//  BaseViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 12/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
