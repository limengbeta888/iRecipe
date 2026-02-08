//
//  InfoSection.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI

struct RecipeInfoView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                RecipeInfoCard(
                    icon: "clock",
                    title: "Prep",
                    value: "\(recipe.prepTimeMinutes) min"
                )
                
                RecipeInfoCard(
                    icon: "flame",
                    title: "Cook",
                    value: "\(recipe.cookTimeMinutes) min"
                )
                
                RecipeInfoCard(
                    icon: "person.2",
                    title: "Servings",
                    value: "\(recipe.servings)"
                )
                
                RecipeInfoCard(
                    icon: "chart.bar",
                    title: "Difficulty",
                    value: recipe.difficulty
                )
                
                RecipeInfoCard(
                    icon: "fork.knife",
                    title: "Cuisine",
                    value: recipe.cuisine
                )
                
                RecipeInfoCard(
                    icon: "bolt.fill",
                    title: "Calories",
                    value: "\(recipe.caloriesPerServing)"
                )
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

// MARK: - Preview
#Preview {
    RecipeInfoView(recipe: Recipe.mock)
}
