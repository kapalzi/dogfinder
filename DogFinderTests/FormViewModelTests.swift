//
//  FormViewModelTests.swift
//  DogFinderTests
//
//  Created by Krzysztof Kapała on 09/11/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import XCTest
@testable import DogFinder

class FormViewModelTests: XCTestCase {
    
    var formViewModel: FormViewModel!
    
    override func setUp() {

        self.formViewModel = FormViewModel(api: MockDogFinderApi.sharedInstance, dogPredictions: [DogPrediction(breed: "Dalmatian", probability: 0.8)], dogPhoto: UIImage())
        
        self.formViewModel.selectBreed(0, completion: {})
        self.formViewModel.selectCategory(0, completion: {})
        self.formViewModel.selectSize(0, completion: {})
        self.formViewModel.setColor(color: "Blue", completion: {})
        self.formViewModel.selectGender(0, completion: {})
        
    }
    
    func testSaveDog() {
        
        self.formViewModel.saveDog(completion: { (message) in
            XCTAssert(message == "Success")
        }) { (error) in
            XCTFail()
        }
    }
}
