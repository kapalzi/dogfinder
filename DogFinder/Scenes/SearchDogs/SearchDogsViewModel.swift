//
//  SearchDogsViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import MapKit

class SearchDogsBaseViewModel: NSObject {

    var dogs: [Dog] = [Dog]()
    let api: DogFinderApiProvider
    var areSpotted: Bool = true

    init(api: DogFinderApiProvider) {
        self.api = api
    }
}
