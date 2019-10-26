//
//  SearchDogsTableViewCell.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 21/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class SearchDogsTableViewCell: UITableViewCell {

    @IBOutlet var dogImageView: UIImageView!
    @IBOutlet weak var breedLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
