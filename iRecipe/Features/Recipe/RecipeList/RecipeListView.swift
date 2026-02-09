//
//  RecipeListView.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI
import Combine

struct RecipeListView: View {
    @ObservedObject var store: RecipeListStore
    @State private var path = [Recipe]()
    @State private var showErrorAlert = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(store.state.recipes) { recipe in
                    RecipeCell(recipe: recipe)
                        .onAppear {
                            if recipe.id == store.state.recipes.last?.id {
                                store.send(.loadMore)
                            }
                        }
                        .onTapGesture {
                            path = [recipe]
                        }
                }

                if store.state.isLoadingMore {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(
                    store: RecipeDetailStore(recipe: recipe),
                    recipe: recipe
                )
            }
            .searchable(
                text: $store.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search recipes"
            )
            .overlay {
                if store.state.isLoading && store.state.recipes.isEmpty {
                    ProgressView("Loading...")
                }
            }
            .alert(
                "Error",
                isPresented: .constant(store.state.errorMessage != nil)
            ) {
                Button("Retry") {
                    store.send(.retry)
                }
            } message: {
                Text(store.state.errorMessage ?? "Something went wrong.")
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

#Preview {
    RecipeListView(
        store: RecipeListStore(
                state: RecipeListState(
                recipes: Recipe.mockList,
                isLoading: false,
                isLoadingMore: false,
                hasMore: false,
                errorMessage: nil,
            )
        )
    )
}
