//
//  SearchDogsViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import MapKit

protocol SearchDogsViewModelDelegate: class {
    func reloadTableView()
}

class SearchDogsViewModel: NSObject, CurrentLocationProtocol {

    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?

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

    func downloadNextNearestSpottedDogs(completionHandler: @escaping (() -> Void)) {

        guard let coordinates = self.lastLocation?.coordinate else { return }
        api.getNextNearestDogs(pageNumber: self.currentPage, areSpotted: true, latitude: coordinates.latitude, longitude: coordinates.longitude, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
            dogs.forEach { self.missingDogs.append($0) }
            self.dogs = self.missingDogs
            completionHandler()
            self.currentPage = self.currentPage + 1
        }) { (error) in
            print(error)
        }
    }
    
    func downloadNextNearestMissingDogs(completionHandler: @escaping (() -> Void)) {

        guard let coordinates = self.lastLocation?.coordinate else { return }
        api.getNextNearestDogs(pageNumber: self.currentPage, areSpotted: false, latitude: coordinates.latitude, longitude: coordinates.longitude, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
            dogs.forEach { self.spottedDogs.append($0) }
            self.dogs = self.spottedDogs
            completionHandler()
            self.currentPage = self.currentPage + 1
        }) { (error) in
            print(error)
        }
    }
    
    func downloadNextNearestSpottedDogsOnMap(completionHandler: @escaping (() -> Void)) {

        guard let coordinates = self.lastLocation?.coordinate else { return }
        api.getNextNearestDogsOnMap(areSpotted: true, latitude: coordinates.latitude, longitude: coordinates.longitude, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
            dogs.forEach { self.missingDogs.append($0) }
            self.dogs = self.missingDogs
            completionHandler()
        }) { (error) in
            print(error)
        }
    }
    
    func downloadNextNearestMissingDogsOnMap(completionHandler: @escaping (() -> Void)) {

        guard let coordinates = self.lastLocation?.coordinate else { return }
        api.getNextNearestDogsOnMap(areSpotted: true, latitude: coordinates.latitude, longitude: coordinates.longitude, completionHandler: { (dogs) in
            guard let dogs = dogs, dogs.count > 0 else { return }
            dogs.forEach { self.missingDogs.append($0) }
            self.dogs = self.missingDogs
            completionHandler()
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
        self.downloadNextNearestSpottedDogs {
            self.delegate?.reloadTableView()
        }
    }

    func showMissing() {

        self.resetPagination()
        self.areSpotted = false
        self.downloadNextNearestMissingDogs {
            self.delegate?.reloadTableView()
        }
    }

}

extension SearchDogsViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {
            self.lastLocation = location
            self.downloadNextNearestSpottedDogs { self.delegate?.reloadTableView() }
        }
    }
}
