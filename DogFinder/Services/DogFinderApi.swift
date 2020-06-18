//
//  DogFinderApi.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 28/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import Alamofire

class DogFinderApi: DogFinderApiProvider {

    public static let sharedInstance = DogFinderApi()

//    private let baseURL = "http://192.168.1.160:5000" //biuro
    private let baseURL = "http://192.168.1.13:5000"    //dom
//    private let baseURL = "http://localhost:5000"

    private enum Endpoint: String {
        case getAllDogs = "/api/dogs"
        case getSpottedDogs = "/api/dogs/spotted"
        case getMissingDogs = "/api/dogs/missing"
        case getPhotos = "/api/dogs/photos"
        case login = "/api/users/login"
        case register = "/api/users/register"
        case map = "/api/dogs/map"
        case date = "/api/dogs/date"
    }

    private func createRequestPath(endpoint: Endpoint, param: String = "") -> String {

        let formedPath = baseURL + "\(endpoint.rawValue)" + "/\(param)"
        return formedPath
    }

    private func createAuthorizationHeaders() -> HTTPHeaders? {

        let header: HTTPHeaders = ["x-access-token": "\(SessionController.sharedInstance.token ?? "")"]

        return header
    }

    public func addDog(_ dog: Dog, completionHandler:@escaping ((String) -> Void), errorHandler:@escaping ((String) -> Void)) {

        AF.request(self.createRequestPath(endpoint: .getAllDogs), method: .post, parameters: dog, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil).responseString { (response) in
            switch response.result {
                case .success(let responseObject):
                    completionHandler(responseObject)

                case .failure(let error):
                    errorHandler(error.localizedDescription)
                }
        }
    }

    public func getNextDogs(pageNumber: Int, areSpotted: Bool, completionHandler:@escaping ((_:[Dog]?) -> Void), errorHandler:@escaping ((_ error: Error) -> Void)) {

        AF.request(self.createRequestPath(endpoint: .date, param: "?page=\(pageNumber)&areSpotted=\(areSpotted)"), method: .get, headers: self.createAuthorizationHeaders()).response { (response) in
            switch response.result {
                case .success(let responseObject):
                    if let payload = responseObject {
                        DogFinderApiParser.parseJsonWithDogs(payload, completionHandler: completionHandler)
                    }

                case .failure:
                    errorHandler(response.error!)
                }
        }
    }

    func getNextNearestDogs(pageNumber: Int, areSpotted: Bool, latitude: Double, longitude: Double, completionHandler:@escaping ((_:[Dog]?) -> Void), errorHandler:@escaping ((_ error: Error) -> Void)) {

        AF.request(self.createRequestPath(endpoint: .getAllDogs, param: "?page=\(pageNumber)&areSpotted=\(areSpotted)&latitude=\(latitude)&longitude=\(longitude)"), method: .get,
                   headers: self.createAuthorizationHeaders()).response { (response) in
            switch response.result {
                case .success(let responseObject):
                    if let payload = responseObject {
                        DogFinderApiParser.parseJsonWithDogs(payload, completionHandler: completionHandler)
                    }

                case .failure:
                    errorHandler(response.error!)
                }
        }
    }

    func getNextNearestDogsOnMap(areSpotted: Bool, latitude: Double, longitude: Double, radius: Double, completionHandler:@escaping ((_:[Dog]?) -> Void), errorHandler:@escaping ((_ error: Error) -> Void)) {

        AF.request(self.createRequestPath(endpoint: .map, param: "?areSpotted=\(areSpotted)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)"), method: .get,
                   headers: self.createAuthorizationHeaders()).response { (response) in
            switch response.result {
                case .success(let responseObject):
                    if let payload = responseObject {
                        DogFinderApiParser.parseJsonWithDogs(payload, completionHandler: completionHandler)
                    }

                case .failure:
                    errorHandler(response.error!)
                }
        }
    }

    public func getUrlOfPhoto(photoName: String) -> URL {

        return URL(string: "\(baseURL)/\(photoName)")!
    }

    public func login(username: String, password: String, completionHandler:@escaping (() -> Void), errorHandler:@escaping ((_ error: Error) -> Void)) {

        let params = ["username": username, "password": password]

        AF.request(self.createRequestPath(endpoint: .login), method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil).response { (response) in
            switch response.result {
            case .success(let responseObject):
                if let payload = responseObject {
                        DogFinderApiParser.parseJsonWithUser(payload, completionHandler: { (user) in
                        SessionController.sharedInstance.currentUser = user
                        if let headers = response.response?.allHeaderFields as? [String: String] {
                            let token = headers["x-auth-token"]
                            SessionController.sharedInstance.token = token
                        }
                    })
                    completionHandler()
                }

            case .failure(let error):
                errorHandler(error)
            }
        }
    }

    public func register(username: String, password: String, email: String, completionHandler:@escaping (() -> Void), errorHandler:@escaping ((_ error: Error) -> Void)) {

        let params = ["email": email, "username": username, "password": password]

        AF.request(self.createRequestPath(endpoint: .register), method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: nil, interceptor: nil).response { (response) in
            switch response.result {
            case .success(let responseObject):
                if let payload = responseObject {
                    DogFinderApiParser.parseJsonWithUser(payload, completionHandler: { (user) in

                        SessionController.sharedInstance.currentUser = user

                        if let headers = response.response?.allHeaderFields as? [String: String] {
                            let token = headers["x-auth-token"]
                            SessionController.sharedInstance.token = token
                        }
                    })
                    completionHandler()
                }
            case  .failure(let error):
                errorHandler(error)
            }
        }
    }
}
