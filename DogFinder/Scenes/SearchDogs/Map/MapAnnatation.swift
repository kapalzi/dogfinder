//
//  MapAnnatation.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 08/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var mapItem: MKMapItem?
    var url: String?
    var image: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
