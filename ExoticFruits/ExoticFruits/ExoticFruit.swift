//
//  ExoticFruit.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-11.
//

import Foundation

struct ExoticFruit: Identifiable, Codable {
    let id: Int
    var name: String
    var description: String
    var countries: [String]
    var image: String
}
