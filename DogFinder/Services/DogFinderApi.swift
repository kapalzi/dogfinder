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
    
//    private let baseURL = "http://192.168.1.160:5000" //biuro
    private let baseURL = "http://192.168.1.16:5000"    //dom
//    private let baseURL = "http://localhost:5000"
    
    private enum Endpoint:String {
        case getAllDogs = "/api/dogs"
        case getPhotos = "/api/dogs/photos"
        case login = "/api/users/login"
        case register = "/api/users/register"
    }
    
    private func createRequestPath(endpoint:Endpoint, param:String = "") -> String {
        
        let formedPath = baseURL + "\(endpoint.rawValue)" + "/\(param)"
        return formedPath
    }
    
    private func createAuthorizationHeaders() -> HTTPHeaders?
    {
        
        let header: HTTPHeaders = ["x-access-token" : "\(SessionController.sharedInstance.token ?? "")"]
        
        return header
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
    
    public func addDog(_ dog: Dog, completionHandler:@escaping ((String) -> Void), errorHandler:@escaping ((String) -> Void)) {
        
        let params = dog.serializeToJson()

        self.performRequest(method: .post, url: self.createRequestPath(endpoint: .getAllDogs), parameters: params, encoding: JSONEncoding.default, headers: nil) { (response) in
            switch response.result {
            case .success(let responseObject):
                let json = JSON(responseObject)
                print(json["message"].string ?? "")
                completionHandler(json["message"].string ?? "")
                
            case .failure(let error):
                errorHandler(error.localizedDescription)
            }
        }
    }
    
    //Get all dogs
    public func getAllDogs(completionHandler:@escaping ((_:[Dog]?) -> Void), errorHandler:@escaping ((_ error:Error) -> Void)) {

        self.performRequest(method: .get, url: self.createRequestPath(endpoint: .getAllDogs), parameters: nil, encoding: JSONEncoding.default, headers: self.createAuthorizationHeaders()) { (response) in
            switch response.result {
            case .success(let responseObject):
                let json = JSON(responseObject)
                
                DogFinderApiParser.parseJsonWithDogs(json, completionHandler: completionHandler)
                
            case .failure(_):
                errorHandler(response.error!)
            }
        }
    }
    
    public func getUrlOfPhoto(photoName: String) -> URL {
        
        return URL(string: "\(baseURL)/\(photoName)")!
    }
    
    public func login(username: String, password: String, completionHandler:@escaping (()->Void), errorHandler:@escaping ((_ error:Error) -> Void)) {
        
        let params = ["username": username, "password": password] as Parameters
        self.performRequest(method: .post, url: self.createRequestPath(endpoint: .login), parameters: params, encoding: JSONEncoding.default, headers: nil) { (response) in
            switch response.result {
            case .success(let responseObject):
                let json = JSON(responseObject)
                DogFinderApiParser.parseJsonWithUser(json, completionHandler: { (user) in
                    
                    SessionController.sharedInstance.currentUser = user
                    
                    if let headers = response.response?.allHeaderFields as? [String: String] {
                        let token = headers["x-auth-token"]
                        SessionController.sharedInstance.token = token
                    }
                })
                completionHandler()
                
            case .failure(_):
                errorHandler(response.error!)
            }
        }
    }
    
    public func register(username: String, password: String, email: String, completionHandler:@escaping (()->Void), errorHandler:@escaping ((_ error:Error) -> Void)) {
        
        let params = ["email": email, "username": username, "password": password] as Parameters
        self.performRequest(method: .post, url: self.createRequestPath(endpoint: .register), parameters: params, encoding: JSONEncoding.default, headers: nil) { (response) in
            switch response.result {
            case .success(let responseObject):
                let json = JSON(responseObject)
                DogFinderApiParser.parseJsonWithUser(json, completionHandler: { (user) in
                    
                    SessionController.sharedInstance.currentUser = user
                    
                    if let headers = response.response?.allHeaderFields as? [String: String] {
                        let token = headers["x-auth-token"]
                        SessionController.sharedInstance.token = token
                    }
                })
                completionHandler()
                
            case .failure(_):
                errorHandler(response.error!)
            }
        }
    }
}
