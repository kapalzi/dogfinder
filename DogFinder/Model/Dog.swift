//
//  Dog.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import SwiftyJSON

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

    let id: String
    let breed: String
    let longitude: Double
    let latitude: Double
    let seenDate: Date
    var photo: String = ""
    var photoName: String = ""
    let user: String
    
    init(id: String = "", breed: String, longitude: Double, latitude: Double, seenDate: Date, photo: String = "", photoName: String = "", user: String) {
        self.id = id
        self.breed = breed
        self.longitude = longitude
        self.latitude = latitude
        self.seenDate = seenDate
        self.photo = photo
        self.user = user
        self.photoName  = photoName
    }
    
    public static func fromJson(json: JSON) -> Dog? {
        
        let dog = Dog(id: json[Dog.kId].string ?? "Unknown",
                      breed: json[Dog.kBreed].string ?? "",
                      longitude: json[Dog.kLongitude].double ?? 0,
                      latitude: json[Dog.kLatitude].double ?? 0,
                      seenDate: SimpleDateFormatter.dateFromUnixInterval(json[Dog.kSeenDate].doubleValue),
                      photoName: json[Dog.kPhotoName].string ?? "",
                      user: json[Dog.kUser].string ?? "")
        
        return dog
    }
    
    public func serializeToJson() -> [String:Any] {
        
        var serializedObject:[String:Any] = [String:Any]()
        
        serializedObject[Dog.kBreed] = self.breed
        serializedObject[Dog.kLongitude] = self.longitude
        serializedObject[Dog.kLatitude] = self.latitude
        serializedObject[Dog.kSeenDate] = self.seenDate.timeIntervalSince1970////SimpleDateFormatter.unixIntvalAsStringFromDate(self.seenDate)
        serializedObject[Dog.kPhoto] = self.photo
        serializedObject[Dog.kUser] = self.user
        
        return serializedObject
    }
}
