//
//  CIRectangleFeature+Extensions.swift
//
//  Created by Ryan Mannion on 2/19/20.
//

import Foundation
import CoreImage

extension Collection where Iterator.Element == CIRectangleFeature {
    public var biggestRectangle: CIRectangleFeature? {
        guard
            var biggestRectangle = first
        else {
            return nil
        }

        var halfPerimeterValue: Float = 0

        forEach { (rectangle) in
            let p1 = rectangle.topLeft
            let p2 = rectangle.topRight
            let width = hypotf(Float(p1.x - p2.x), Float(p1.y - p2.y))

            let p3 = rectangle.topLeft
            let p4 = rectangle.bottomLeft
            let height = hypotf(Float(p3.x - p4.x), Float(p3.y - p4.y))

            let currentHalfPerimeterValue = height + width

            if halfPerimeterValue < currentHalfPerimeterValue {
                halfPerimeterValue = currentHalfPerimeterValue
                biggestRectangle = rectangle
            }
        }

        return biggestRectangle
    }
}
