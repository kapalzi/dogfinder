//
//  Dog.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

enum DogsSize: Int, Codable {
    case small = 0
    case medium = 1
    case big = 2
    case large = 3
}

enum DogsGender: Int, Codable {
    case male = 0
    case female = 1
    case unknown = 2
}

class Dog: Hashable, Codable {

    static func == (lhs: Dog, rhs: Dog) -> Bool {
        return lhs._id == rhs._id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }

    let _id: String
    let breed: String
    let longitude: Double
    let latitude: Double
    let seenDate: Date
    var photo: String = ""
    var photoName: String = ""
    let user: String
    let isSpotted: Bool
    let size: DogsSize
    let color: String
    let gender: DogsGender
    let depiction: String

    init(id: String = "", breed: String, longitude: Double, latitude: Double, seenDate: Date, photo: String = "", photoName: String = "", user: String, isSpotted: Bool, size: DogsSize, color: String, gender: DogsGender, depiction: String) {

        self._id = id
        self.breed = breed
        self.longitude = longitude
        self.latitude = latitude
        self.seenDate = seenDate
        self.photo = photo
        self.user = user
        self.photoName  = photoName
        self.isSpotted = isSpotted
        self.size = size
        self.color = color
        self.gender = gender
        self.depiction = depiction
    }

    public func getStringForSize() -> String {

        switch self.size {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .big:
            return "Small"
        case .large:
            return "Medium"
        }
    }

    public func getStringForGender() -> String {

        switch gender {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .unknown:
            return "Unknown"
        }
    }

    public func getStringForCategory() -> String {

        if self.isSpotted == true {
            return "Spotted"
        } else {
            return "Missing"
        }
    }
}
