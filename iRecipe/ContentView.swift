//
//  ContentView.swift
//  iRecipe
//
//  Created by Meng Li on 07/02/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @StateObject private var recipeListStore = RecipeListStore()
    
    var body: some View {
        RecipeListView(store: recipeListStore)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
