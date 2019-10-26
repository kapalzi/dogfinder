//
//  UIImage+Extension.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 09/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

extension UIImage {

    // MARK: Transformations

    func resize(newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        UIGraphicsGetCurrentContext()?.interpolationQuality = .high
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()?.interpolationQuality = .default
        UIGraphicsEndImageContext()
        return newImage
    }

    func pixelBuffer() -> CVPixelBuffer? {
        // NOTE: Create pixel buffer with specified pixel format
        var pixelBuffer: CVPixelBuffer?
        let options = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ARGB, options, &pixelBuffer)
        guard status == kCVReturnSuccess, let finalPixelBuffer = pixelBuffer else {
            return nil
        }

        // NOTE: Create context ("canvas") for drawing pixels
        CVPixelBufferLockBaseAddress(finalPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(finalPixelBuffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(finalPixelBuffer), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
            return nil
        }
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)

        // NOTE: Draw pixels on the context, updates pixel buffer
        UIGraphicsPushContext(context)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(finalPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))

        return finalPixelBuffer
    }
}
