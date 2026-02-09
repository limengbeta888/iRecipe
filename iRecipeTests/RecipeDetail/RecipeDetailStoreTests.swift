//
//  RecipeDetailStoreTests.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import XCTest
import Combine
@testable import iRecipe

@MainActor
final class RecipeDetailStoreTests: XCTestCase {

    private var store: RecipeDetailStore!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
        store = RecipeDetailStore(recipe: mockRecipe())
    }

    override func tearDown() {
        cancellables = nil
        store = nil
        super.tearDown()
    }

    func test_sendShare_emitsShareEffect() {
        let expectation = XCTestExpectation(description: "Share effect emitted")

        store.effects
            .sink { effect in
                XCTAssertEqual(effect, .shareRecipe)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        store.send(.share)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_sendShare_doesNotChangeState() {
        let initialState = store.state

        store.send(.share)

        XCTAssertEqual(store.state, initialState)
    }
    
    // MARK: - Helpers
    func mockRecipe(id: Int = 1) -> Recipe {
        Recipe(
            id: id,
            name: "Pasta",
            ingredients: ["Noodles", "Sauce"],
            instructions: ["Boil", "Mix"],
            prepTimeMinutes: 10,
            cookTimeMinutes: 20,
            servings: 2,
            difficulty: "Easy",
            cuisine: "Italian",
            caloriesPerServing: 400,
            tags: ["Dinner"],
            userId: 1,
            image: "",
            rating: 4.5,
            reviewCount: 100,
            mealType: ["Main"]
        )
    }
}
