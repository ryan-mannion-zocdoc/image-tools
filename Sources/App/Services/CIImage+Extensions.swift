//
//  CIImage+Extensions.swift
//
//  Created by Ryan Mannion on 2/19/20.
//

import Foundation
import CoreImage

extension CIImage {
    enum Orientation {
        case portrait
        case landscape
    }

    func isValidCaptureAspectRatio(orientation: Orientation, shouldInvertRatio: Bool) -> Bool {
        let ratio: CGFloat
        if shouldInvertRatio {
            ratio = extent.size.width > 0 ? extent.size.height / extent.size.width : 0
        } else {
            ratio = extent.size.height > 0 ? extent.size.width / extent.size.height : 0
        }

        let validRatios: Range<CGFloat>
        switch orientation {
        case .landscape:
            validRatios = 1.5..<1.75
        case .portrait:
            validRatios = 0.55..<0.70
        }
        let isValid = validRatios.contains(ratio)

        return isValid
    }

    public func combined(with image: CIImage) throws -> CIImage {
        let combineFilter = try nonnull(CIFilter(name: "CISourceOverCompositing"))

        let transform = CGAffineTransform(
            translationX: extent.midX - (image.extent.size.width / 2),
            y: extent.midY - (image.extent.size.height / 2)
        )

        combineFilter.setValue(image.transformed(by: transform), forKey: "inputImage")
        combineFilter.setValue(self, forKey: "inputBackgroundImage")

        return try nonnull(combineFilter.outputImage)
    }

//    public func overlay(rectangle: CIRectangleFeature, color: UIColor = UIColor(hex: 0xfff04b, alpha: 0.2)) -> CIImage {
//        var overlay = CIImage(color: CIColor(cgColor: color.cgColor))
//
//        overlay = overlay.cropped(to: extent)
//
//        let parameters: [String: Any] = [
//            "inputExtent": CIVector(cgRect: extent),
//            "inputTopLeft": CIVector(cgPoint: rectangle.topLeft),
//            "inputTopRight": CIVector(cgPoint: rectangle.topRight),
//            "inputBottomLeft": CIVector(cgPoint: rectangle.bottomLeft),
//            "inputBottomRight": CIVector(cgPoint: rectangle.bottomRight)
//        ]
//
//        overlay = overlay.applyingFilter("CIPerspectiveTransformWithExtent", parameters: parameters)
//
//        return overlay.composited(over: self)
//    }

    public func constrastFilter(contrast: Float = 1.1) -> CIImage? {
        let parameters: [String: Any] = [
            "inputContrast": contrast,
            kCIInputImageKey: self
        ]

        let filter = CIFilter(name: "CIColorControls", parameters: parameters)

        return filter?.outputImage
    }

    public func blackWhiteFilter(contrast: Float = 1.14, brightness: Float = 0, saturation: Float = 0) -> CIImage? {
        let parameters: [String: Any] = [
            "inputContrast": contrast,
            "inputBrightness": brightness,
            "inputSaturation": saturation,
            kCIInputImageKey: self
        ]

        let filter = CIFilter(name: "CIColorControls", parameters: parameters)

        return filter?.outputImage
    }

    public func perspectiveCorrected(for rectangle: CIRectangleFeature) -> CIImage {
        let parameters: [String: Any] = [
            "inputTopLeft": CIVector(cgPoint: rectangle.topLeft),
            "inputTopRight": CIVector(cgPoint: rectangle.topRight),
            "inputBottomLeft": CIVector(cgPoint: rectangle.bottomLeft),
            "inputBottomRight": CIVector(cgPoint: rectangle.bottomRight)
        ]

        return applyingFilter("CIPerspectiveCorrection", parameters: parameters)
    }

    public func scaleFilter(scale: Float) -> CIImage? {
        let parameters: [String: Any] = [
            "inputScale": scale,
            "inputAspectRatio": 1.0,
            kCIInputImageKey: self
        ]

        let filter = CIFilter(name: "CILanczosScaleTransform", parameters: parameters)

        return filter?.outputImage
    }

    public func exposureAdjustmentFilter(exposure: Float) -> CIImage? {
        let parameters: [String: Any] = [
            "inputEV": exposure,
            kCIInputImageKey: self
        ]

        let filter = CIFilter(name: "CIExposureAdjust", parameters: parameters)

        return filter?.outputImage
    }
}
