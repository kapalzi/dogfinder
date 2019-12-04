//
//  SearchDogsViewModelTests.swift
//  DogFinderTests
//
//  Created by Krzysztof Kapała on 07/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import XCTest
@testable import DogFinder

class SearchDogsTableViewModelTests: XCTestCase {
    
    var searchDogsViewModel: SearchDogsTableViewModel!
    
    override func setUp() {
        
        self.searchDogsViewModel = SearchDogsTableViewModel(api: MockDogFinderApi.sharedInstance)
        
        let dog1 = Dog(id: "1", breed: "Dalmatian", longitude: 10, latitude: 11, seenDate: Date(), photo: "1", photoName: "1", user: "1", isSpotted: true, size: DogsSize(rawValue: 1)!, color: "1", gender: DogsGender(rawValue: 1)!, depiction: "1")
        let dog2 = Dog(id: "2", breed: "Doberman", longitude: 10, latitude: 11, seenDate: Date(), photo: "1", photoName: "1", user: "1", isSpotted: false, size: DogsSize(rawValue: 1)!, color: "1", gender: DogsGender(rawValue: 1)!, depiction: "1")
        
        self.searchDogsViewModel.dogs = [dog1]
        self.searchDogsViewModel.missingDogs = [dog2]
        self.searchDogsViewModel.spottedDogs = [dog1]
    }

    override func tearDown() {
        
        self.searchDogsViewModel.dogs = [Dog]()
        self.searchDogsViewModel.missingDogs = [Dog]()
        self.searchDogsViewModel.spottedDogs = [Dog]()
    }
     
    
    func testDownloadNextSpottedDogs() {
        
        self.searchDogsViewModel.downloadNextSpottedDogs {
            print(self.searchDogsViewModel.spottedDogs.count)
            XCTAssert(self.searchDogsViewModel.spottedDogs.count == 2)
        }
    }
    
    func testDownloadNextMissingDogs() {
        
        self.searchDogsViewModel.downloadNextMissingDogs {
            XCTAssert(self.searchDogsViewModel.missingDogs.count == 3)
        }
    }

    func testShowSpotted() {

        self.searchDogsViewModel.showSpotted {
            XCTAssert(self.searchDogsViewModel.currentPage == 0
            && self.searchDogsViewModel.areSpotted == true)
        }
    }
    
    func testShowMissing() {

        self.searchDogsViewModel.showMissing {
            XCTAssert(self.searchDogsViewModel.currentPage == 0
            && self.searchDogsViewModel.areSpotted == false)
        }
    }

}
