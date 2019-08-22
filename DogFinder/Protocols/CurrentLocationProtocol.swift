//
//  CurrentLocationProtocol.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 16/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import MapKit

protocol CurrentLocationProtocol: CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager? { get set }
    var lastLocation: CLLocation? { get set }
    
    func initLocationManager()
}

extension CurrentLocationProtocol {
    
    func initLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.distanceFilter = kCLDistanceFilterNone
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
}
