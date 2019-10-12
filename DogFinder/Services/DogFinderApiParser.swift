//
//  DogFinderApiParser.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 30/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DogFinderApiParser {

    public class func parseJsonWithDogs(_ json:JSON, completionHandler:@escaping ((_:[Dog])->Void)) {

        var dogRecords = [Dog]()
        
        for subJson in json.arrayValue {
            if let dogRecord = Dog.fromJson(json: subJson) {
                dogRecords.append(dogRecord)
            }
        }
        
        DispatchQueue.main.async {
            completionHandler(dogRecords)
            return
        }
    }
    
    public class func parseJsonWithDogPhotos(_ json:JSON, completionHandler:@escaping ((_:[DogPhoto])->Void)) {
        
        var dogPhotoRecords = [DogPhoto]()
        
        for subJson in json.arrayValue {
            if let dogPhotoRecord = DogPhoto.fromJson(json: subJson) {
                dogPhotoRecords.append(dogPhotoRecord)
            }
        }
        
        DispatchQueue.main.async {
            completionHandler(dogPhotoRecords)
            return
        }
    }

}