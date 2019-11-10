//
//  LoadMoreTableViewCell.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 10/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class LoadMoreTableViewCell: UITableViewCell {

    @IBOutlet var loader: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.loader.startAnimating()

        self.selectionStyle = .none
        self.accessoryType = .none
    }
}
