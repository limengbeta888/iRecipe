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
                
                Text("Recipe count: \(store.state.recipes.count)")
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
                if store.state.isLoading {
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
                Text(store.state.errorMessage ?? "Something went wrong")
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

// MARK: - Preview

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PreviewWrapper()
                .previewDisplayName("English")
                .environment(\.locale, Locale(identifier: "en"))
            
            PreviewWrapper()
                .previewDisplayName("Chinese")
                .environment(\.locale, Locale(identifier: "zh-Hans"))
        }
    }
    
    private struct PreviewWrapper: View {
        let store =  RecipeListStore(
            state: RecipeListState(
            recipes: Recipe.mockList,
            isLoading: false,
            hasMore: false,
            errorMessage: nil,
        ))
        
        var body: some View {
            RecipeListView(store: store)
        }
    }
}
