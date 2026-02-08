//
//  RecipeIngredientsView.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI

struct RecipeIngredientsView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                            .foregroundColor(.blue)
                            .padding(.top, 6)
                        
                        Text(ingredient)
                            .font(.body)
                    }
                    
                    if index < recipe.ingredients.count - 1 {
                        Divider()
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

// MARK: - Preview
#Preview {
    RecipeIngredientsView(recipe: Recipe.mock)
}
