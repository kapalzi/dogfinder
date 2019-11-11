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
    let api: DogFinderApiProvider
    weak var delegate: SearchDogsViewModelDelegate?
    var currentPage = 0
    var areSpotted: Bool = true

    var spottedDogs: [Dog] = [Dog]()
    var missingDogs: [Dog] = [Dog]()

    init(api: DogFinderApiProvider) {
        self.api = api
    }

    func downloadNextSpottedDogs(completionHandler: @escaping (() -> Void)) {

        api.getNextDogs(pageNumber: self.currentPage, areSpotted: true, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
            dogs.forEach { self.spottedDogs.append($0) }
            self.dogs = self.spottedDogs
            completionHandler()
            self.currentPage = self.currentPage + 1
        }) { (error) in
            print(error)
        }
    }

    func downloadNextMissingDogs(completionHandler: @escaping (() -> Void)) {

        api.getNextDogs(pageNumber: self.currentPage, areSpotted: false, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
            dogs.forEach { self.missingDogs.append($0) }
            self.dogs = self.missingDogs
            completionHandler()
            self.currentPage = self.currentPage + 1
        }) { (error) in
            print(error)
        }
    }

    private func resetPagination() {
        self.currentPage = 0
        self.missingDogs = [Dog]()
        self.spottedDogs = [Dog]()
    }

    func showSpotted() {

        self.resetPagination()
        self.areSpotted = true
        self.downloadNextSpottedDogs {
            self.delegate?.reloadTableView()
        }
    }

    func showMissing() {

        self.resetPagination()
        self.areSpotted = false
        self.downloadNextMissingDogs {
            self.delegate?.reloadTableView()
        }
    }

}
