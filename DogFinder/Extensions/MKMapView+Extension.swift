//
//  MKMapView+Extension.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 16/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import MapKit

extension MKMapView {

    var topLeftCoordinate: CLLocationCoordinate2D {
        return convert(CGPoint.zero, toCoordinateFrom: self)
    }
    var radius: CLLocationDistance {

        let centerLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        let topLeftLocation = CLLocation(latitude: topLeftCoordinate.latitude, longitude: topLeftCoordinate.longitude)
        return centerLocation.distance(from: topLeftLocation)
    }
}
