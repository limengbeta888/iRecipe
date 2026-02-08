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
    
    var body: some View {
        NavigationStack(path: $path) {
            content
                .navigationTitle("Recipes")
                .onAppear {
                    store.send(.onAppear)
                }
                .navigationDestination(for: Recipe.self) { recipe in
                    RecipeDetailView(recipe: recipe, store: RecipeDetailStore())
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch store.state {
        case .idle:
            EmptyView()

        case .loading:
            ProgressView("Loading recipes...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded(let recipes):
            List(recipes) { recipe in
                RecipeCell(recipe: recipe)
                    .onTapGesture {
                        path = [recipe]
                    }
            }
            .listStyle(.plain)
            .refreshable {
                store.send(.refresh)
            }

        case .error(let message):
            VStack(spacing: 12) {
                Text(message)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)

                Button("Retry") {
                    store.send(.retry)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    let store = RecipeListStore(state: .loaded(Recipe.mockList))
    RecipeListView(store: store)
}
