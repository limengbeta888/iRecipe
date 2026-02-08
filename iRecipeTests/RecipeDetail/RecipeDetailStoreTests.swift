//
//  RecipeDetailStoreTests.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Combine
import XCTest
@testable import iRecipe

final class RecipeDetailStoreTests: XCTestCase {

    func test_share_emitsEffect() {
        let recipe = Recipe.mock
        let store = RecipeDetailStore(recipe: recipe)

        let expectation = XCTestExpectation(description: "Share effect emitted")

        let cancellable = store.effects.sink { effect in
            if case .shareRecipe = effect {
                expectation.fulfill()
            }
        }

        store.send(.share)

        wait(for: [expectation], timeout: 1)
        cancellable.cancel()
    }
}
