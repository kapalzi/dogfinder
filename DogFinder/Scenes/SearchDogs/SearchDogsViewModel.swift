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
    let api: DogFinderApiProvider
    weak var delegate: SearchDogsViewModelDelegate?
    var currentPage = 1
    var areSpotted: Bool = true

    init(api: DogFinderApiProvider) {
        self.api = api
    }

    func downloadNextDogs(areSpotted: Bool = true, completionHandler: @escaping (() -> Void)) {

        api.getNextDogs(pageNumber: self.currentPage, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
            dogs.forEach { self.allDogs.append($0) }
            self.dogs = self.allDogs.filter { !$0.isSpotted }

            if areSpotted {
                self.dogs = self.allDogs.filter { $0.isSpotted }
            } else {
                self.dogs = self.allDogs.filter { !$0.isSpotted }
            }

            completionHandler()
            self.currentPage = self.currentPage + 1
        }) { (error) in
            print(error)
        }
    }

    private func resetPagination() {
        self.currentPage = 1
        self.allDogs = [Dog]()
    }

    private func changeTo(spotted: Bool) {

        self.resetPagination()
        self.areSpotted = spotted
        self.downloadNextDogs(areSpotted: spotted) {
            self.delegate?.reloadTableView()
        }
    }

    func showSpotted() {

        self.changeTo(spotted: true)
    }

    func showMissing() {

        self.changeTo(spotted: false)
    }

}
