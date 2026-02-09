//
//  RecipeListStoreTests.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import XCTest
import XCTest
import Combine
import Swinject

@testable import iRecipe

final class RecipeListStoreTests: XCTestCase {
    private var container: Container!
    private var store: RecipeListStore!
    private var mockService: MockRecipeService!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        mockService = MockRecipeService()
        cancellables = []

        container = Container()
        container.register(RecipeServiceProtocol.self) { _ in
            self.mockService
        }

        store = RecipeListStore(container: container)
    }

    override func tearDown() {
        store = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }
    
    @MainActor
    func test_onAppear_loadsRecipes() async {
        let recipes = (1...3).map { mockRecipe(id: $0) }

        mockService.fetchRecipesResult = .success(
            RecipeResponse(recipes: recipes, total: 3, skip: 0, limit: 20)
        )

        store.send(.onAppear)

        await XCTAssertEventually {
            self.store.state.isLoading == false &&
            self.store.state.recipes.count == 3
        }
    }
    
    @MainActor
    func test_loadMore_appendsRecipes() async {
        let firstBatch = (1...2).map { mockRecipe(id: $0) }
        let secondBatch = (3...4).map { mockRecipe(id: $0) }

        mockService.fetchRecipesResult = .success(
            RecipeResponse(recipes: firstBatch, total: 4, skip: 0, limit: 20)
        )

        store.send(.onAppear)

        await XCTAssertEventually {
            self.store.state.recipes.count == 2
        }

        mockService.fetchRecipesResult = .success(
            RecipeResponse(recipes: secondBatch, total: 4, skip: 2, limit: 20)
        )

        store.send(.loadMore)

        await XCTAssertEventually {
            self.store.state.recipes.count == 4
        }
    }
    
    @MainActor
    func test_search_replacesRecipes() async {
        let searched = [mockRecipe(id: 99)]

        mockService.searchRecipesResult = .success(
            RecipeResponse(recipes: searched, total: 1, skip: 0, limit: 0)
        )

        store.send(.search("cake"))

        await XCTAssertEventually {
            self.store.state.isSearching &&
            self.store.state.recipes.first?.id == 99
        }
    }
    
    @MainActor
    func test_cancelSearch_restoresLoadedRecipes() async {
        let loaded = [mockRecipe(id: 1)]
        let searched = [mockRecipe(id: 99)]

        mockService.fetchRecipesResult = .success(
            RecipeResponse(recipes: loaded, total: 1, skip: 0, limit: 20)
        )

        store.send(.onAppear)

        await XCTAssertEventually {
            self.store.state.recipes.count == 1
        }

        mockService.searchRecipesResult = .success(
            RecipeResponse(recipes: searched, total: 1, skip: 0, limit: 0)
        )

        store.send(.search("cake"))

        await XCTAssertEventually {
            self.store.state.recipes.first?.id == 99
        }

        store.send(.cancelSearch)

        XCTAssertEqual(store.state.recipes.first?.id, 1)
    }
    
    @MainActor
    func test_loadRecipes_failure_setsError() async {
        mockService.fetchRecipesResult = .failure(URLError(.notConnectedToInternet))

        store.send(.onAppear)

        await XCTAssertEventually {
            self.store.state.errorMessage != nil &&
            self.store.state.isLoading == false
        }
    }
    
    // MARK: - Helpers
    private func mockRecipe(id: Int = 1) -> Recipe {
        Recipe(
            id: id,
            name: "Recipe \(id)",
            ingredients: [],
            instructions: [],
            prepTimeMinutes: 10,
            cookTimeMinutes: 20,
            servings: 2,
            difficulty: "Easy",
            cuisine: "Test",
            caloriesPerServing: 200,
            tags: [],
            userId: 1,
            image: "",
            rating: 4.5,
            reviewCount: 10,
            mealType: ["Dinner"]
        )
    }
}
