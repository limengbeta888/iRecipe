//
//  RecipeDetailReducerTests.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import XCTest
@testable import iRecipe

@MainActor
final class RecipeDetailReducerTests: XCTestCase {
    private var reducer: RecipeDetailReducer!

    override func setUp() {
        super.setUp()
        reducer = RecipeDetailReducer()
    }

    func test_shareIntent_returnsShareEffect_andKeepsState() {
        let state = RecipeDetailState()

        let (newState, effect) = reducer.reduce(
            state: state,
            intent: .share
        )

        XCTAssertEqual(newState, state)
        XCTAssertEqual(effect, .shareRecipe)
    }
}
