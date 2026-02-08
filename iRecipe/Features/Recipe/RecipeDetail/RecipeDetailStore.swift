//
//  RecipeDetailStore.swift
//  iRecipe
//
//  Created by Meng Li on 08/02/2026.
//

import Combine
import SwiftUI

final class RecipeDetailStore: ObservableObject {
    @Published private(set) var state: RecipeDetailState = .favorite(false)
    
    private let reducer = RecipeDetailReducer()
    
    func send(_ intent: RecipeDetailIntent) {
        state = reducer.reduce(state: state, intent: intent)
    }
}
