//
//  SearchDogsTableViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 16/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import MapKit

class SearchDogsTableViewModel: SearchDogsBaseViewModel {

    var currentPage = 0
    var spottedDogs: [Dog] = [Dog]()
    var missingDogs: [Dog] = [Dog]()

    func downloadNextSpottedDogs(completionHandler: @escaping (() -> Void)) {
        api.getNextDogs(pageNumber: self.currentPage, areSpotted: true, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { completionHandler(); return }
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
            guard let dogs = dogs, dogs.count > 0 else { completionHandler(); return }
            dogs.forEach { self.missingDogs.append($0) }
            self.dogs = self.missingDogs
            completionHandler()
            self.currentPage = self.currentPage + 1
        }) { (error) in
            print(error)
        }
    }

//    func downloadNextNearestSpottedDogs(completionHandler: @escaping (() -> Void)) {
//
//        guard let coordinates = self.lastLocation?.coordinate else { return }
//        api.getNextNearestDogs(pageNumber: self.currentPage, areSpotted: true, latitude: coordinates.latitude, longitude: coordinates.longitude, completionHandler: { (dogs) in
//            guard let dogs = dogs, dogs.count > 0 else { completionHandler(); return }
//            dogs.forEach { self.spottedDogs.append($0) }
//            self.dogs = self.spottedDogs
//            completionHandler()
//            self.currentPage = self.currentPage + 1
//        }) { (error) in
//            print(error)
//        }
//    }
//
//    func downloadNextNearestMissingDogs(completionHandler: @escaping (() -> Void)) {
//
//        guard let coordinates = self.lastLocation?.coordinate else { return }
//        api.getNextNearestDogs(pageNumber: self.currentPage, areSpotted: false, latitude: coordinates.latitude, longitude: coordinates.longitude, completionHandler: { (dogs) in
//            guard let dogs = dogs, dogs.count > 0 else { completionHandler(); return }
//            dogs.forEach { self.missingDogs.append($0) }
//            self.dogs = self.missingDogs
//            completionHandler()
//            self.currentPage = self.currentPage + 1
//        }) { (error) in
//            print(error)
//        }
//    }

    private func resetPagination() {
        self.currentPage = 0
        self.missingDogs = [Dog]()
        self.spottedDogs = [Dog]()
        self.dogs = [Dog]()
    }

    func showSpotted(completionHandler: @escaping (() -> Void)) {

        self.resetPagination()
        self.areSpotted = true
        self.downloadNextSpottedDogs {
            completionHandler()
        }
    }

    func showMissing(completionHandler: @escaping (() -> Void)) {

        self.resetPagination()
        self.areSpotted = false
        self.downloadNextMissingDogs {
            completionHandler()
        }
    }
}
