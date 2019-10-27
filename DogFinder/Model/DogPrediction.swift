//
//  DogPrediction.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 12/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

struct DogPrediction {

    let breed: String
    let probability: Float

    func buttonTitleString() -> String {

        if self.breed == "Mixed-breed" {
            return self.breed
        }
        return String(format: "%@ (%3.2f%%)", self.breed, self.probability * 100)
    }
}
