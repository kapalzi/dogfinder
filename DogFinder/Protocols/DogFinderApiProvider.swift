//
//  DogFinderApiProvider.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 09/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation

protocol DogFinderApiProvider {

    func getNextDogs(pageNumber: Int, areSpotted: Bool, completionHandler:@escaping ((_:[Dog]?) -> Void), errorHandler:@escaping ((_ error: Error) -> Void))
    func addDog(_ dog: Dog, completionHandler:@escaping ((String) -> Void), errorHandler:@escaping ((String) -> Void))
    func login(username: String, password: String, completionHandler:@escaping (() -> Void), errorHandler:@escaping ((_ error: Error) -> Void))
    func register(username: String, password: String, email: String, completionHandler:@escaping (() -> Void), errorHandler:@escaping ((_ error: Error) -> Void))
}
