//
//  RecipeListReducerTests.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

@testable import iRecipe
import XCTest

final class RecipeListReducerTests: XCTestCase {
    private var reducer: RecipeListReducer!

    override func setUp() {
        super.setUp()
        reducer = RecipeListReducer()
    }

    override func tearDown() {
        reducer = nil
        super.tearDown()
    }
    
    func test_onAppear_whenEmpty_setsLoading() {
        let state = mockBaseState()

        let newState = reducer.reduce(state: state, intent: .onAppear)

        XCTAssertTrue(newState.isLoading)
        XCTAssertNil(newState.errorMessage)
    }
    
    @MainActor
    func test_onAppear_whenNotEmpty_doesNothing() {
        let state = mockBaseState(
            recipes: [mockRecipe(id: 1)]
        )

        let newState = reducer.reduce(state: state, intent: .onAppear)

        XCTAssertEqual(newState, state)
    }
    
    func test_loadMore_whenHasMoreAndNotLoading_startsLoading() {
        let state = mockBaseState(
            isLoading: false,
            isSearching: false,
            hasMore: true
        )

        let newState = reducer.reduce(state: state, intent: .loadMore)

        XCTAssertTrue(newState.isLoading)
        XCTAssertNil(newState.errorMessage)
    }
    
    @MainActor
    func test_loadMore_whenAlreadyLoading_isIgnored() {
        let state = mockBaseState(isLoading: true)

        let newState = reducer.reduce(state: state, intent: .loadMore)

        XCTAssertEqual(newState, state)
    }
    
    @MainActor
    func test_loadMore_whileSearching_isIgnored() {
        let state = mockBaseState(isSearching: true)

        let newState = reducer.reduce(state: state, intent: .loadMore)

        XCTAssertEqual(newState, state)
    }
    
    func test_retry_setsLoading() {
        let state = mockBaseState(errorMessage: "Error")

        let newState = reducer.reduce(state: state, intent: .retry)

        XCTAssertTrue(newState.isLoading)
        XCTAssertNil(newState.errorMessage)
    }
    
    func test_search_resetsRecipesAndStartsLoading() {
        let loaded = [mockRecipe(id: 1)]

        let state = mockBaseState(
            recipes: loaded,
            loadedRecipes: loaded
        )

        let newState = reducer.reduce(state: state, intent: .search("cake"))

        XCTAssertTrue(newState.isSearching)
        XCTAssertTrue(newState.isLoading)
        XCTAssertTrue(newState.recipes.isEmpty)
        XCTAssertTrue(newState.searchedRecipes.isEmpty)
        XCTAssertNil(newState.errorMessage)
    }
    
    func test_cancelSearch_restoresLoadedRecipes() {
        let loaded = [mockRecipe(id: 1)]
        let searched = [mockRecipe(id: 99)]

        let state = mockBaseState(
            recipes: searched,
            loadedRecipes: loaded,
            searchedRecipes: searched,
            isSearching: true
        )

        let newState = reducer.reduce(state: state, intent: .cancelSearch)

        XCTAssertFalse(newState.isSearching)
        XCTAssertFalse(newState.isLoading)
        XCTAssertEqual(newState.recipes, loaded)
        XCTAssertTrue(newState.searchedRecipes.isEmpty)
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
    
    private func mockBaseState(
        recipes: [Recipe] = [],
        loadedRecipes: [Recipe] = [],
        searchedRecipes: [Recipe] = [],
        isLoading: Bool = false,
        isSearching: Bool = false,
        hasMore: Bool = true,
        errorMessage: String? = nil
    ) -> RecipeListState {
        var state = RecipeListState()
        state.recipes = recipes
        state.loadedRecipes = loadedRecipes
        state.searchedRecipes = searchedRecipes
        state.isLoading = isLoading
        state.isSearching = isSearching
        state.hasMore = hasMore
        state.errorMessage = errorMessage
        return state
    }

}
