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
    
    private let api = ExoticFruitApi()
    
    func addFruit(_ fruit: ExoticFruit) {
        api.createFruit(fruit) { success in
            DispatchQueue.main.async {
                if success {
                    self.fetchAllFruits() // Refresh the list after adding
                } else {
                    self.errorMessage = ErrorMessage(message: "Failed to add the fruit.")
                }
            }
        }
    }
    
    func deleteFruit(id: Int) {
        api.deleteFruit(id: id) { success in
            DispatchQueue.main.async {
                if success {
                    self.fruits.removeAll { $0.id == id } // Remove locally after deleting
                } else {
                    self.errorMessage = ErrorMessage(message: "Failed to delete the fruit.")
                }
            }
        }
    }
    
    func fetchAllFruits() {
        ExoticFruitApi().loadAllFruits { [weak self] fruits in
            print("Completion handler called with \(fruits.count) fruits.")
            self?.fruits = fruits
        }
    }
}
