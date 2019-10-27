//
//  DogDetailsViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 27/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class DogDetailsViewController: UITableViewController {

        private var viewModel: DogDetailsViewModel!

    override func viewDidLoad() {

        self.initControls()
    }

    func initViewModel(dog: Dog) {

        self.viewModel = DogDetailsViewModel(dog: dog)
    }

    private func initControls() {

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(self.cancelClicked(_:)))

    }

    @IBAction func cancelClicked(_: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
