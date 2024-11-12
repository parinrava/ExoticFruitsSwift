//
//  ExoticFruit.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-11.
//

import Foundation

struct ExoticFruit: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let countries: [String]
    let image: String
}
