//
//  Nonnull.swift
//
//
//  Created by Ryan Mannion on 6/25/22.
//

import Foundation

///
/// Attempts a failable constructor
///
public func nonnull<Value>(
    _ value: Value?,
    file: StaticString = #file,
    line: Int = #line
)
    throws -> Value
{
    guard let value = value else {
        throw NSError()
    }
    return value
}
