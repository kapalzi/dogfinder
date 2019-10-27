//
//  Dog.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import SwiftyJSON

enum DogsSize: Int {
    case small = 0
    case medium = 1
    case big = 2
    case large = 3
}

enum DogsGender: Int {
    case male = 0
    case female = 1
    case unknown = 2
}

class Dog: Hashable {

    static func == (lhs: Dog, rhs: Dog) -> Bool {
        return lhs.id == rhs.id //&& lhs.breed == rhs.breed && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.user == rhs.user && lhs.seenDate == rhs.seenDate && lhs.photo == rhs.photo
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static let kDog = "dog"
    static let kDogs = "dogs"
    static let kId = "_id"
    static let kBreed = "breed"
    static let kLongitude = "longitude"
    static let kLatitude = "latitude"
    static let kSeenDate = "seenDate"
    static let kPhoto = "photo"
    static let kPhotoName = "photoName"
    static let kUser = "user"
    static let kIsSpotted = "isSpotted"
    static let kSize = "size"
    static let kColor = "color"
    static let kGender = "gender"
    static let kDepiction = "depiction"

    let id: String
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

        self.id = id
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

    public static func fromJson(json: JSON) -> Dog? {

        let dog = Dog(id: json[Dog.kId].string ?? "Unknown",
                    breed: json[Dog.kBreed].string ?? "",
                    longitude: json[Dog.kLongitude].double ?? 0,
                    latitude: json[Dog.kLatitude].double ?? 0,
                    seenDate: SimpleDateFormatter.dateFromJs(json[Dog.kSeenDate].string ?? "") ?? Date(),
                    photoName: json[Dog.kPhotoName].string ?? "",
                    user: json[Dog.kUser].string ?? "",
                    isSpotted: json[Dog.kIsSpotted].bool ?? true,
                    size: DogsSize(rawValue: json[Dog.kUser].intValue) ?? .medium,
                    color: json[Dog.kColor].string ?? "",
                    gender: DogsGender(rawValue: json[Dog.kGender].intValue) ?? .unknown,
                    depiction: json[Dog.kDepiction].string ?? "")

        return dog
    }

    public func serializeToJson() -> [String: Any] {

        var serializedObject: [String: Any] = [String: Any]()

        serializedObject[Dog.kBreed] = self.breed
        serializedObject[Dog.kLongitude] = self.longitude
        serializedObject[Dog.kLatitude] = self.latitude
        serializedObject[Dog.kSeenDate] = self.seenDate.timeIntervalSince1970
        serializedObject[Dog.kPhoto] = self.photo
        serializedObject[Dog.kUser] = self.user
        serializedObject[Dog.kIsSpotted] = self.isSpotted
        serializedObject[Dog.kSize] = self.size.rawValue
        serializedObject[Dog.kColor] = self.color
        serializedObject[Dog.kGender] = self.gender.rawValue
        serializedObject[Dog.kDepiction] = self.depiction

        return serializedObject
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
