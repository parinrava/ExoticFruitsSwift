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
    
    func updateFruit(_ fruit: ExoticFruit, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: "https://dotneta2v3-fbhwd5bfcffxd3fx.westus-01.azurewebsites.net/api/ExoticFruit/Update/\(fruit.id)") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(fruit)
            request.httpBody = jsonData
        } catch {
            print("Error encoding fruit: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating fruit: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Check if we received a non-200 HTTP status code
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Failed to update fruit. Status code: \(httpResponse.statusCode)")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(false)
                return
            }
            
            completion(true)
        }
        task.resume()
    }

}
