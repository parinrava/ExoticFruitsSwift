//
//  Item.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

import Foundation
import SwiftData

struct Item: Codable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var countries: [String]
    var imageBase64: String
}
