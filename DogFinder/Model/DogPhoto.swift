//
//  DogPhoto.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 08/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DogPhoto: Codable {
    
    static let kId = "_id"
    static let kDogId = "dogId"
    static let kPhoto = "photo"
 
    
    let id: String
    let dogId: String
    let photo: String
    
    public static func fromJson(json: JSON) -> DogPhoto? {
        
        let dogPhoto = DogPhoto(id: json[DogPhoto.kId].string ?? "Unknonw",
                                dogId: json[DogPhoto.kDogId].string ?? "Unknonw",
                                photo: json[Dog.kPhoto].string ?? "")
        
        return dogPhoto
    }
}

