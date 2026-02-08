//
//  RecipeListStoreTests.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import XCTest
import XCTest
@testable import iRecipe

final class RecipeListStoreTests: XCTestCase {

    func test_loadRecipes_success() async {
        // Arrange
        let mockService = MockRecipeService()
        mockService.result = .success(
            RecipeResponse(recipes: Recipe.mockList)
        )

        let container = makeTestContainer(recipeService: mockService)
        let store = RecipeListStore(container: container)

        // Act
        store.send(.onAppear)

        // Allow async task to finish
        try? await Task.sleep(nanoseconds: 300_000_000)

        // Assert
        XCTAssertEqual(store.state, .loaded(Recipe.mockList))
    }

    func test_loadRecipes_failure() async {
        enum TestError: Error { case failed }

        let mockService = MockRecipeService()
        mockService.result = .failure(TestError.failed)

        let container = makeTestContainer(recipeService: mockService)
        let store = RecipeListStore(container: container)

        store.send(.onAppear)

        try? await Task.sleep(nanoseconds: 300_000_000)

        if case .error = store.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected error state")
        }
    }
}
