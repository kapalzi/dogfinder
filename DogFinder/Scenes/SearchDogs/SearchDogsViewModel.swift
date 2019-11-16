//
//  SearchDogsViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import MapKit

protocol SearchDogsBaseViewModelDelegate: class {
    func downloadDogs()
}

class SearchDogsBaseViewModel: NSObject, CurrentLocationProtocol {

    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?

    var dogs: [Dog] = [Dog]()
    let api: DogFinderApiProvider
    weak var delegate: SearchDogsBaseViewModelDelegate?
    var areSpotted: Bool = true

    var spottedDogs: [Dog] = [Dog]()
    var missingDogs: [Dog] = [Dog]()

    init(api: DogFinderApiProvider) {
        self.api = api
    }
}

extension SearchDogsBaseViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {
            self.lastLocation = location
//            self.delegate?.downloadDogs()
        }
    }
}
