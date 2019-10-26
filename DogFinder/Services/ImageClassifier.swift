//
//  ImageClassifier.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 09/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit
import Foundation
import Vision
import CoreMedia

// MARK: - ImageClassifier

class ImageClassifier {

    // MARK: Properties

    private let studentDogModel = StudentDogModel()

    // MARK: Image Classification

    func classifyImageWithVision(image: CGImage, completionHandler: @escaping ([DogPrediction]) -> Void) {
        guard let visionModel = try? VNCoreMLModel(for: studentDogModel.model) else {
            return
        }

        let request = VNCoreMLRequest(model: visionModel) { request, _ in
            if let observations = request.results as? [VNClassificationObservation] {
                let top3 = observations
                    .prefix(through: 2)
                    .map { DogPrediction(breed: $0.identifier, probability: $0.confidence) }
                completionHandler(top3)
            }
        }

        let handler = VNImageRequestHandler(cgImage: image)
        try? handler.perform([request])
    }
}
