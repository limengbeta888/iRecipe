//
//  RecipeTitleCardView.swift
//  iRecipe
//
//  Created by Terry Li on 08/02/2026.
//

import SwiftUI

struct RecipeTitleCardView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: recipe.image)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            ProgressView()
                        }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay {
                            Image(systemName: "photo")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                        }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 300)
            .clipped()
            
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
