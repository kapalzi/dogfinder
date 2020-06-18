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

class FormViewModel: BaseViewModel, CurrentLocationProtocol {

    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?

    var dogPredictions: [DogPrediction]
    let dogPhoto: UIImage
    let categories: [String]
    let sizes: [String]
    let genders: [String]
    private var breed: String?
    private var isSpotted: Bool?
    private var size: DogsSize?
    private var color: String?
    private var gender: DogsGender?
    private var depiction: String?

    init(api: DogFinderApiProvider, dogPredictions: [DogPrediction], dogPhoto: UIImage) {

        self.dogPredictions = dogPredictions
        self.dogPredictions.append(DogPrediction(breed: "Mixed-breed", probability: 0.5))
        self.dogPhoto = dogPhoto
        self.categories = ["Missing", "Spotted"]
        self.sizes = ["Small", "Medium", "Big", "Large"]
        self.genders = ["Male", "Female", "Unknown"]

        super.init(api: api)
    }

    func selectBreed(_ breedNumber: Int, completion: (() -> Void)) {

        self.breed = self.dogPredictions[breedNumber].breed
        completion()
    }

    func selectCategory(_ categoryNumber: Int, completion: (() -> Void)) {

        if categoryNumber == 0 {
            self.isSpotted = false
        } else {
            self.isSpotted = true
        }

        completion()
    }

    func selectSize(_ sizeNumber: Int, completion: (() -> Void)) {

        self.size = DogsSize(rawValue: sizeNumber)
        completion()
    }

    func selectGender(_ genderNumber: Int, completion: (() -> Void)) {

        self.gender = DogsGender(rawValue: genderNumber)
        completion()
    }

    func setDepiciton(text: String) {
        self.depiction = text
    }

    func setColor(color: String, completion: (() -> Void)) {
        self.color = color
        completion()
    }

    func setOwnBreed(breed: String, completion: (() -> Void)) {
        self.breed = breed
        completion()
    }

    func saveDog(completion: @escaping ((String) -> Void), error: @escaping ((String) -> Void)) {

        guard let breed = self.breed, self.breed != "" else {
            error("Breed is not set!")
            return
        }

        guard let coordinates = self.lastLocation?.coordinate else { return }

        let dogImageData = self.dogPhoto.jpegData(compressionQuality: 0.1)
        let dogImageBase = dogImageData?.base64EncodedString()

        guard let isSpotted = self.isSpotted else {
            error("Category is not set!")
            return
        }

        guard let size = self.size else {
            error("Size is not set!")
            return
        }

        guard let color = self.color else {
            error("Color is not set!")
            return
        }

        guard let gender = self.gender else {
            error("Gender is not set!")
            return
        }

        let dog = Dog(breed: breed, longitude: coordinates.longitude, latitude: coordinates.latitude, seenDate: Date(), photo: dogImageBase ?? "", user: SessionController.sharedInstance.currentUser._id, isSpotted: isSpotted, size: size, color: color, gender: gender, depiction: depiction ?? "")

        self.api.addDog(dog, completionHandler: completion, errorHandler: error)
    }
}

extension FormViewModel: CLLocationManagerDelegate {

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
