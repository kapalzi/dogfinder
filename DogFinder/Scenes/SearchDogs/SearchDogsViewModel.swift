//
//  SearchDogsViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

protocol SearchDogsViewModelDelegate: class {
    func reloadTableView()
}

class SearchDogsViewModel {

    var dogs: [Dog] = [Dog]()
    var allDogs: [Dog] = [Dog]()
    weak var delegate: SearchDogsViewModelDelegate?

    func downloadAllDogs() {

        DogFinderApi.sharedInstance.getAllDogs(completionHandler: { (dogs) in
            guard let dogs = dogs else { return }
            self.allDogs = dogs
            self.dogs = dogs.filter { $0.isSpotted }
            self.delegate?.reloadTableView()
        }) { (error) in
            print(error)
        }
    }

    func showSpotted() {

        self.dogs = self.allDogs.filter { $0.isSpotted }
        self.delegate?.reloadTableView()
    }

    func showMissing() {

        self.dogs = self.allDogs.filter { !$0.isSpotted }
        self.delegate?.reloadTableView()
    }

    func downloadDogsAreSpotted(areSpotted: Bool) {

        DogFinderApi.sharedInstance.getFilteredSpottedDogs(areSpotted: areSpotted, completionHandler: { (dogs) in
            guard let dogs = dogs else { return }
            self.dogs = dogs
            self.delegate?.reloadTableView()
        }, errorHandler: { (error) in
            print(error)
        })
    }

    func addNewDogs(newDogs: [Dog]) {

        let dogsToAdd = Set(self.dogs).symmetricDifference(Set(newDogs))
        dogsToAdd.forEach { self.dogs.append($0) }
        self.delegate?.reloadTableView()
    }

}
