//
//  ItemApi.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

import Foundation


class ItemApi: ObservableObject {
    // Replace this with your actual API base URL
    private let baseURL = "https://your-backend-url.com/api/items"
    
    // MARK: - Load Data (GET)
    func loadData(completion: @escaping ([Item]) -> ()) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL...")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let items = try decoder.decode([Item].self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(items)
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Network error:", error)
            }
        }
        task.resume()
    }
    
    // MARK: - Create Item (POST)
    func createItem(_ item: Item, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(item)
        } catch {
            print("Encoding error:", error)
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
        task.resume()
    }
    
    // MARK: - Update Item (PUT)
    func updateItem(_ item: Item, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: "\(baseURL)/\(item.id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(item)
        } catch {
            print("Encoding error:", error)
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
        task.resume()
    }
    
    // MARK: - Delete Item (DELETE)
    func deleteItem(_ itemID: UUID, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: "\(baseURL)/\(itemID)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
        task.resume()
    }
}
