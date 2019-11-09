//
//  BaseViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 09/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {

    let api: DogFinderApiProvider

    init(api: DogFinderApiProvider) {
        self.api = api
    }
}
