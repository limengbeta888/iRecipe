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

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                recipeList
                    .navigationTitle("Recipes")
                    .toolbar {
                        if case .loading = store.state {
                            ToolbarItem(placement: .principal) {
                                ProgressView()
                            }
                        }
                    }

                if case .loading = store.state {
                    loadingOverlay
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
            .alert(
                "Failed to load recipes",
                isPresented: $showErrorAlert,
                actions: {
                    Button("Retry") {
                        store.send(.retry)
                    }
                },
                message: {
                    Text(errorMessage)
                }
            )
            .onChange(of: store.state) {
                if case .error = store.state {
                    showErrorAlert = true
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(
                    store: RecipeDetailStore(recipe: recipe, isFavorite: false),
                    recipe: recipe
                )
            }
        }
    }
    
    var recipeList: some View {
        List {
            if case .loaded(let recipes) = store.state {
                ForEach(recipes) { recipe in
                    RecipeCell(recipe: recipe)
                        .onTapGesture {
                            path = [recipe]
                        }
                }
            }
        }
        .listStyle(.plain)
        .refreshable {
            store.send(.refresh)
        }
    }
    
    var loadingOverlay: some View {
        VStack {
            ProgressView("Loading recipes...")
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding(.top, 8)

            Spacer()
        }
    }
    
    var errorMessage: String {
        if case .error(let message) = store.state {
            return message
        }
        return "Something went wrong."
    }
}

#Preview {
    RecipeListView(
        store: RecipeListStore(state: .loaded(Recipe.mockList))
    )
}
