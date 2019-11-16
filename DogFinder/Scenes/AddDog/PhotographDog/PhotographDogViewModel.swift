//
//  PhotographDogViewModel
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import Foundation
import UIKit
import CoreMedia

class PhotographDogViewModel {

    let classifier = ImageClassifier()

    func checkUserSession(completion: @escaping (() -> Void)) {

        if SessionController.sharedInstance.currentUser == nil || SessionController.sharedInstance.token == nil {
            completion()
        }
    }

    func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage {

        let imageBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        let image = self.convert(cmage: ciImage)
        return image
    }

    private func convert(cmage: CIImage) -> UIImage {
        let context: CIContext = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }

    func recognizeImage(_ image: UIImage?, completionHandler:@escaping ((_:[DogPrediction]) -> Void)) {

        if let image = image, let cgImage = image.cgImage {

            classifier.classifyImageWithVision(image: cgImage) { (results) in

                DispatchQueue.main.async {
                    completionHandler(results)
                }
            }
        }
    }
}
