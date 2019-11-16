//
//  SearchDogsMapViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 16/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import MapKit

class SearchDogsMapViewModel: SearchDogsBaseViewModel {

    private var centerLocation: CLLocationCoordinate2D?
    private var  radius: Double?

    func set(_ center: CLLocationCoordinate2D, _ radius: Double) {
        self.centerLocation = center
        self.radius = radius
    }

    private func getCoordinates() -> CLLocationCoordinate2D? {

        if self.centerLocation != nil {
            return self.centerLocation!
        } else {
            if self.lastLocation?.coordinate != nil {
                return self.lastLocation!.coordinate
            } else {
                return nil
            }
        }
    }

    func downloadNextNearestSpottedDogsOnMap(completionHandler: @escaping (() -> Void)) {

        let optionalCoordinates = self.getCoordinates()
        guard let coordinates = optionalCoordinates else {
            completionHandler()
            return
        }

        api.getNextNearestDogsOnMap(areSpotted: true, latitude: coordinates.latitude, longitude: coordinates.longitude, radius: self.radius ?? 1000, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
//            dogs.forEach { self.missingDogs.append($0) }
//            self.dogs = self.missingDogs
            self.dogs = dogs
            completionHandler()
        }) { (error) in
            print(error)
        }
    }

    func downloadNextNearestMissingDogsOnMap(completionHandler: @escaping (() -> Void)) {

        let optionalCoordinates = self.getCoordinates()
        guard let coordinates = optionalCoordinates else {
            completionHandler()
            return
        }

        api.getNextNearestDogsOnMap(areSpotted: false, latitude: coordinates.latitude, longitude: coordinates.longitude, radius: self.radius ?? 1000, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
//            dogs.forEach { self.missingDogs.append($0) }
//            self.dogs = self.missingDogs
            self.dogs = dogs
            completionHandler()
        }) { (error) in
            print(error)
        }
    }

    func showSpotted(completionHandler: @escaping (() -> Void)) {

        self.areSpotted = true
        self.downloadNextNearestSpottedDogsOnMap {
            completionHandler()
        }
    }

    func showMissing(completionHandler: @escaping (() -> Void)) {

        self.areSpotted = false
        self.downloadNextNearestMissingDogsOnMap {
            completionHandler()
        }
    }
}
