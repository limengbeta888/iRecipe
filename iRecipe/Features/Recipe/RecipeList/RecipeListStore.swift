//
//  RecipeListStore.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Combine
import SwiftUI
import Swinject

final class RecipeListStore: ObservableObject {
    @Published private(set) var state = RecipeListState()
    @Published var searchText: String = ""
    
    private let reducer = RecipeListReducer()
    private let recipeService: RecipeServiceProtocol

    private var isPreview: Bool = false
    private let limit = 20
    private var skip = 0
    private var cancellables = Set<AnyCancellable>()
    
    init(container: Container = AppDelegate.container) {
        recipeService = container.resolve(RecipeServiceProtocol.self)!
        
        // Debounce search text
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .scan(("", "")) { previous, newValue in
                (previous.1, newValue)
            }
            .sink { [weak self] oldValue, newValue in
                guard let self else { return }
                if !oldValue.isEmpty, newValue.isEmpty {
                    self.send(.cancelSearch)
                } else if !newValue.isEmpty {
                    self.send(.search(newValue))
                }
            }
            .store(in: &cancellables)
    }

    // Only for Preview
    convenience init(state: RecipeListState) {
        self.init()
        self.state = state
        self.isPreview = true
    }
    
    // MARK: - Intent
    func send(_ intent: RecipeListIntent) {
        guard !(isPreview && intent == .onAppear) else { return }

        let newState = reducer.reduce(state: state, intent: intent)
        guard newState != state else { return }

        state = newState

        switch intent {
        case .onAppear, .loadMore, .retry:
            if state.isLoading || state.isLoadingMore {
                loadRecipes()
            }
        case .search(let keyword):
            searchRecipes(keyword)
            
        case .cancelSearch:
            break
        }
    }

    // MARK: - Side Effect
    private func loadRecipes() {
        Task {
            do {
                let response = try await recipeService.fetchRecipes(limit: limit, skip: skip)

                skip += response.recipes.count

                state.isLoading = false
                state.isLoadingMore = false
                state.recipes.append(contentsOf: response.recipes)
                state.hasMore = !response.recipes.isEmpty

            } catch {
                state.isLoading = false
                state.isLoadingMore = false
                state.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func searchRecipes(_ keyword: String) {
        Task {
            do {
                let response = try await recipeService.searchRecipes(limit: 0, skip: 0, keyword: keyword)
                state.isLoading = false
                state.isLoadingMore = false
                state.hasMore = false
                state.recipes.append(contentsOf: response.recipes)

            } catch {
                state.isLoading = false
                state.isLoadingMore = false
                state.hasMore = false
                state.recipes = state.loadedRecipes
                state.errorMessage = error.localizedDescription
            }
        }
    }
}
