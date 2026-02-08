//
//  RecipeInfoCard.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI

struct RecipeInfoCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .frame(width: 100, height: 100)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Preview
#Preview {
    RecipeInfoCard(icon: "clock", title: "Prep", value: "1 min")
}
