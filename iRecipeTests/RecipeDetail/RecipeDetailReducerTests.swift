//
//  RecipeDetailReducerTests.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import XCTest
@testable import iRecipe

final class RecipeDetailReducerTests: XCTestCase {

    let reducer = RecipeDetailReducer()

    func test_toggleFavorite() {
        let state = RecipeDetailState.idle(isFavorite: false)

        let (newState, effect) = reducer.reduce(
            state: state,
            intent: .toggleFavorite
        )

        XCTAssertEqual(newState, .idle(isFavorite: true))
        XCTAssertNil(effect)
    }

    func test_share_emitsEffect() {
        let state = RecipeDetailState.idle(isFavorite: false)

        let (_, effect) = reducer.reduce(
            state: state,
            intent: .share
        )

        XCTAssertEqual(effect, .shareRecipe)
    }
}
