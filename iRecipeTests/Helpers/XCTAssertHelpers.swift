//
//  XCTAssertHelpers.swift
//  iRecipe
//
//  Created by Meng Li on 09/02/2026.
//

import XCTest
@testable import iRecipe

func XCTAssertEventually(
    timeout: TimeInterval = 1,
    file: StaticString = #file,
    line: UInt = #line,
    _ condition: @escaping () -> Bool
) async {
    let start = Date()
    while Date().timeIntervalSince(start) < timeout {
        if condition() { return }
        try? await Task.sleep(nanoseconds: 50_000_000)
    }
    XCTFail("Condition not met in time", file: file, line: line)
}
