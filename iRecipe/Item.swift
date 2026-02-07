//
//  Item.swift
//  iRecipe
//
//  Created by Meng Li on 07/02/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
