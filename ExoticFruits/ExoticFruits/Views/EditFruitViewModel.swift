//
//  EditFruitView.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-11.
//

// EditFruitView.swift
import Foundation
import SwiftUI

class ExoticFruitViewModel: ObservableObject {
    @Published var fruits: [ExoticFruit] = []
    @Published var errorMessage: ErrorMessage? = nil

    func fetchAllFruits() {
        ExoticFruitApi().loadAllFruits { [weak self] fruits in
            print("Completion handler called with \(fruits.count) fruits.")
            self?.fruits = fruits
        }
    }
}
