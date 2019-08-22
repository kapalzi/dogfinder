//
//  ConfirmDogViewModel.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 12/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ConfirmDogViewModel: NSObject, CurrentLocationProtocol  {
    
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    
    let dogPredictions: [DogPrediction]
    let dogPhoto: UIImage
    private var selectedBreed: String?
    
    init(dogPredictions: [DogPrediction], dogPhoto: UIImage) {
        
        self.dogPredictions = dogPredictions
        self.dogPhoto = dogPhoto
    }
    
    func selectBreed(_ breedNumber: Int, completion: (()->Void)) {
        
        self.selectedBreed = self.dogPredictions[breedNumber].breed
        completion()
    }
    
    func saveDog() {
        
        guard let breed = self.selectedBreed, self.selectedBreed != "" else {
            return
        }
        
        guard let coordinates = self.lastLocation?.coordinate else { return }
        
        
        let dogImageData = self.dogPhoto.jpegData(compressionQuality: 0.1)
        let dogImageBase = dogImageData?.base64EncodedString()
        let dog1 = Dog(id: "", breed: breed, longitude: coordinates.longitude, latitude: coordinates.latitude, seenDate: Date(), photo: dogImageBase!, user: "Admin")
        
        DogFinderApi.sharedInstance.addDog(dog1)
    }
    
    func validateForSave() {
    }
}

extension ConfirmDogViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.lastLocation = location
        }
    }
}
