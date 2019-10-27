//
//  BaseDetailsViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 27/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class BaseDetailsViewController: UITableViewController {

    @IBOutlet var breedView: UIView!
    @IBOutlet var categoryView: UIView!
    @IBOutlet var sizeView: UIView!
    @IBOutlet var colorView: UIView!
    @IBOutlet var genderView: UIView!
    @IBOutlet var depictionView: UIView!

    override func viewDidLoad() {

        self.initControls()
    }

     func initControls() {

        self.breedView.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.categoryView.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.sizeView.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.colorView.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.genderView.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
        self.depictionView.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return self.view.bounds.width
    }

}
