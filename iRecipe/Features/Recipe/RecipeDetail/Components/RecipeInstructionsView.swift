//
//  RecipeInstructionsView.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI

struct RecipeInstructionsView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Instructions")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 28, height: 28)
                            
                            Text("\(index + 1)")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        Text(instruction)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    if index < recipe.instructions.count - 1 {
                        Divider()
                            .padding(.leading, 40)
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
    RecipeInstructionsView(recipe: Recipe.mock)
}
