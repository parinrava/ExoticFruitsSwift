//
//  Item.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
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
