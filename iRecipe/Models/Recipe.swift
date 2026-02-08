//
//  Recipe.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Foundation

// MARK: - Recipe Response
struct RecipeResponse: Codable {
    let recipes: [Recipe]
    let total: Int?
    let skip: Int?
    let limit: Int?
}

// MARK: - Recipe Model
struct Recipe: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
    
    // Computed properties for convenience
    var totalTimeMinutes: Int {
        prepTimeMinutes + cookTimeMinutes
    }
    
    var formattedRating: String {
        String(format: "%.1f", rating)
    }
}

// MARK: - Mock Data for Previews
extension Recipe {
    static let mock = Recipe(
        id: 1,
        name: "Classic Margherita Pizza",
        ingredients: [
            "Pizza dough",
            "Tomato sauce",
            "Fresh mozzarella cheese",
            "Fresh basil leaves",
            "Olive oil",
            "Salt and pepper to taste"
        ],
        instructions: [
            "Preheat the oven to 475°F (245°C).",
            "Roll out the pizza dough and spread tomato sauce evenly.",
            "Top with slices of fresh mozzarella and fresh basil leaves.",
            "Drizzle with olive oil and season with salt and pepper.",
            "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
            "Slice and serve hot."
        ],
        prepTimeMinutes: 20,
        cookTimeMinutes: 15,
        servings: 4,
        difficulty: "Easy",
        cuisine: "Italian",
        caloriesPerServing: 300,
        tags: ["Pizza", "Italian"],
        userId: 166,
        image: "https://cdn.dummyjson.com/recipe-images/1.webp",
        rating: 4.6,
        reviewCount: 98,
        mealType: ["Dinner"]
    )
    
    static let mockList: [Recipe] = [
        mock,
        Recipe(
            id: 2,
            name: "Vegetarian Stir-Fry",
            ingredients: [
                "Tofu, cubed",
                "Broccoli florets",
                "Carrots, sliced",
                "Bell peppers, sliced",
                "Soy sauce",
                "Ginger, minced",
                "Garlic, minced",
                "Sesame oil",
                "Cooked rice for serving"
            ],
            instructions: [
                "In a wok, heat sesame oil over medium-high heat.",
                "Add minced ginger and garlic, sauté until fragrant.",
                "Add cubed tofu and stir-fry until golden brown.",
                "Add broccoli, carrots, and bell peppers. Cook until vegetables are tender-crisp.",
                "Pour soy sauce over the stir-fry and toss to combine.",
                "Serve over cooked rice."
            ],
            prepTimeMinutes: 15,
            cookTimeMinutes: 20,
            servings: 3,
            difficulty: "Medium",
            cuisine: "Asian",
            caloriesPerServing: 250,
            tags: ["Vegetarian", "Stir-fry", "Asian"],
            userId: 143,
            image: "https://cdn.dummyjson.com/recipe-images/2.webp",
            rating: 4.7,
            reviewCount: 26,
            mealType: ["Lunch"]
        )
    ]
}
