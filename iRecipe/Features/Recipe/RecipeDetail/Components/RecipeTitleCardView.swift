//
//  RecipeTitleCardView.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import SwiftUI
import NukeUI
import Nuke

struct RecipeTitleCardView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Nuke LazyImage
            if let url = URL(string: recipe.image) {
                LazyImage(request: ImageRequest(url: url)) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else if state.error != nil {
                        // Failed to load
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .overlay {
                                Image(systemName: "photo")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                            }
                    } else {
                        // Loading placeholder
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .overlay {
                                ProgressView()
                            }
                    }
                }
                .frame(height: 300)
                .clipped()
            } else {
                // Invalid URL fallback
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 300)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                    }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(recipe.formattedRating)
                        .fontWeight(.semibold)
                    Text("(\(recipe.reviewCount) reviews)")
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)
                
                // Tags
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(recipe.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    RecipeTitleCardView(recipe: Recipe.mock)
}
