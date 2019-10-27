//
//  UIAlertController+Extension.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 27/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {

    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }

    func setTitleColor(color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)

        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor: titleColor], //3
                                          range: NSRange(location: 0, length: title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }

    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}
