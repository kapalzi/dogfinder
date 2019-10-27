//
//  UIView+Extension.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 19/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

extension UIView {

    func dropShadow(backgroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 15
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
