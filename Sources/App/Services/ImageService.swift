//
//  ImageService.swift
//
//
//  Created by Ryan Mannion on 11/20/23.
//

import CoreImage
import Foundation

class ImageService {
    private let rectangleDetector = CIDetector(
        ofType: CIDetectorTypeRectangle,
        context: nil,
        options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]
    )

    init() {

    }

    public func getCardShapedImage(orientation: CIImage.Orientation, ciImage: CIImage) -> CIImage? {
        guard
            let enhancedImage = ciImage.constrastFilter(),
            let biggestRectangle = rectangleDetector?
                .features(in: enhancedImage)
                .compactMap({ (feature) -> CIRectangleFeature? in
                    feature as? CIRectangleFeature
                })
                .biggestRectangle
        else {
            return nil
        }

        let perspectiveCorrectedImage = enhancedImage.perspectiveCorrected(for: biggestRectangle)
//        print("Corrected")
//        guard
//            perspectiveCorrectedImage.isValidCaptureAspectRatio(
//                orientation: orientation,
//                shouldInvertRatio: false
//            )
//        else {
//            print("NOT VALID!")
//            return nil
//        }
//        print("VALID CAPTURE")

        return perspectiveCorrectedImage
    }
}
