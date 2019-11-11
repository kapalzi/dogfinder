//
//  MockDogFinderApi.swift
//  DogFinderTests
//
//  Created by Krzysztof Kapała on 09/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
@testable import DogFinder

class MockDogFinderApi: DogFinderApiProvider {

    public static let sharedInstance = MockDogFinderApi()
    
    func getNextDogs(pageNumber: Int, areSpotted: Bool, completionHandler: @escaping (([Dog]?) -> Void), errorHandler: @escaping ((Error) -> Void)) {
        let dog1 = Dog(id: "1", breed: "Dalmatian", longitude: 10, latitude: 11, seenDate: Date(), photo: "1", photoName: "1", user: "1", isSpotted: true, size: DogsSize(rawValue: 1)!, color: "1", gender: DogsGender(rawValue: 1)!, depiction: "1")
        let dog2 = Dog(id: "2", breed: "Doberman", longitude: 10, latitude: 11, seenDate: Date(), photo: "1", photoName: "1", user: "1", isSpotted: false, size: DogsSize(rawValue: 1)!, color: "1", gender: DogsGender(rawValue: 1)!, depiction: "1")
        let dog3 = Dog(id: "3", breed: "Doberman", longitude: 10, latitude: 11, seenDate: Date(), photo: "1", photoName: "1", user: "1", isSpotted: false, size: DogsSize(rawValue: 1)!, color: "1", gender: DogsGender(rawValue: 1)!, depiction: "1")
        
        if areSpotted {
            completionHandler([dog1])
        } else {
            completionHandler([dog2, dog3])
        }
        
        
    }
    
    func addDog(_ dog: Dog, completionHandler: @escaping ((String) -> Void), errorHandler: @escaping ((String) -> Void)) {
        completionHandler("Success")
    }
    
    func login(username: String, password: String, completionHandler: @escaping (() -> Void), errorHandler: @escaping ((Error) -> Void)) {
        SessionController.sharedInstance.token = "token"
        completionHandler()
    }
    
    func register(username: String, password: String, email: String, completionHandler: @escaping (() -> Void), errorHandler: @escaping ((Error) -> Void)) {
        SessionController.sharedInstance.token = "token"
        completionHandler()
    }
}
