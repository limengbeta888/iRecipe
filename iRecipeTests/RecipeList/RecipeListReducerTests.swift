//
//  RecipeListReducerTests.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import XCTest
@testable import iRecipe

final class RecipeListReducerTests: XCTestCase {
    let reducer = RecipeListReducer()

    func test_onAppear_setsLoading() {
        let state = RecipeListState.idle

        let newState = reducer.reduce(
            state: state,
            intent: RecipeListIntent.onAppear
        )

        XCTAssertEqual(newState, .loading)
    }

    func test_loadSuccess_setsLoaded() {
        let recipes = Recipe.mockList

        let newState = reducer.reduce(
            state: .loading,
            intent: .loadSuccess(recipes: recipes)
        )

        XCTAssertEqual(newState, .loaded(recipes))
    }
}
