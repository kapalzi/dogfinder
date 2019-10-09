//
//  DogFinderApi.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 28/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DogFinderApi {
    public static let sharedInstance = DogFinderApi()
    
//    private let baseURL = "http://192.168.1.160:5000"
    private let baseURL = "http://localhost:5000"
    
    private enum Endpoint:String {
        case getAllDogs = "/api/dogs"
        case getPhotos = "/api/dogs/photos"
    }
    
    private func createRequestPath(endpoint:Endpoint, param:String = "") -> String {
        
        let formedPath = baseURL + "\(endpoint.rawValue)" + "/\(param)"
        
        return formedPath
    }
    
    private func performRequest(method:HTTPMethod, url:String, parameters:Parameters?, encoding:ParameterEncoding, headers:[String:String]?, handler:((_:(DataResponse<Any>)) -> Void)?)
    {
        do
        {
            try Alamofire.request(url.asURL(), method: method, parameters: parameters, encoding: encoding, headers: headers)
                .responseJSON { response in
                    handler?(response)
            }
        }
        catch
        {
            print(error)
        }
    }
    
    public func addDog(_ dog: Dog) {
        
        let params = dog.serializeToJson()

        self.performRequest(method: .post, url: self.createRequestPath(endpoint: .getAllDogs), parameters: params, encoding: JSONEncoding.default, headers: nil) { (response) in
//            switch response.result {
//            case .success(let responseObject):
//
//                let json = JSON(responseObject)
//ope
//            case .failure(_):
//                print(response.error)
//            }
        }
    }
    
    //Get all dogs
    public func getAllDogs(completionHandler:@escaping ((_:[Dog]?) -> Void), errorHandler:@escaping ((_ error:Error) -> Void)) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let header: HTTPHeaders = [
//        "Authorization" : "Bearer \(appDelegate.token)"
//        ]
        
        self.performRequest(method: .get, url: self.createRequestPath(endpoint: .getAllDogs), parameters: nil, encoding: JSONEncoding.default, headers: nil) { (response) in
            switch response.result {
            case .success(let responseObject):
                let json = JSON(responseObject)
                
                DogFinderApiParser.parseJsonWithDogs(json, completionHandler: completionHandler)
                
            case .failure(_):
                errorHandler(response.error!)
            }
        }
    }
    
    public func getAllDogPhotos(completionHandler:@escaping ((_:[DogPhoto]?) -> Void), errorHandler:@escaping ((_ error:Error) -> Void)) {
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //        let header: HTTPHeaders = [
        //        "Authorization" : "Bearer \(appDelegate.token)"
        //        ]
        
        self.performRequest(method: .get, url: self.createRequestPath(endpoint: .getPhotos), parameters: nil, encoding: JSONEncoding.default, headers: nil) { (response) in
            switch response.result {
            case .success(let responseObject):
                let json = JSON(responseObject)
                
                DogFinderApiParser.parseJsonWithDogPhotos(json, completionHandler: completionHandler)
                
            case .failure(_):
                errorHandler(response.error!)
            }
        }
    }
    
    public func getUrlOfPhoto(photoName: String) -> URL {
        
        return URL(string: "\(baseURL)/\(photoName)")!
    }
}
