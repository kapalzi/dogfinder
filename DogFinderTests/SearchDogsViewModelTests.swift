//
//  SearchDogsViewModelTests.swift
//  DogFinderTests
//
//  Created by Krzysztof Kapała on 07/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import XCTest
@testable import DogFinder

class SearchDogsViewModelTests: XCTestCase {
    
    let searchDogsViewModel: SearchDogsViewModel = SearchDogsViewModel(api: MockDogFinderApi.sharedInstance)

    override func setUp() {
        
        let dog1 = Dog(id: "1", breed: "Dalmatian", longitude: 10, latitude: 11, seenDate: Date(), photo: "1", photoName: "1", user: "1", isSpotted: true, size: DogsSize(rawValue: 1)!, color: "1", gender: DogsGender(rawValue: 1)!, depiction: "1")
        let dog2 = Dog(id: "2", breed: "Doberman", longitude: 10, latitude: 11, seenDate: Date(), photo: "1", photoName: "1", user: "1", isSpotted: false, size: DogsSize(rawValue: 1)!, color: "1", gender: DogsGender(rawValue: 1)!, depiction: "1")
        
        self.searchDogsViewModel.allDogs = [dog1, dog2]
        self.searchDogsViewModel.dogs = [Dog]()
    }

    override func tearDown() {
        
        self.searchDogsViewModel.dogs = [Dog]()
        self.searchDogsViewModel.allDogs = [Dog]()
    }
    
    func testDownloadAllDogs() {
        
        self.searchDogsViewModel.downloadNextDogs {
            XCTAssert(self.searchDogsViewModel.allDogs.count == 3)
        }
        
        
    }

    func testShowSpotted() {

        self.searchDogsViewModel.showSpotted()

        XCTAssert(self.searchDogsViewModel.dogs.count == 1)
    }
    
    func testShowMissing() {

        self.searchDogsViewModel.showMissing()
        
        XCTAssert(self.searchDogsViewModel.dogs.count == 1)
    }

}
