import Foundation

class ExoticFruitApi: ObservableObject {
    
    func loadAllFruits(completion: @escaping ([ExoticFruit]) -> ()) {
        // Update URL to fetch all fruits
        guard let url = URL(string: "https://dotneta2v3-fbhwd5bfcffxd3fx.westus-01.azurewebsites.net/api/ExoticFruit") else {
            print("Invalid URL.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            // Print the raw JSON data to confirm the response structure
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            
            do {
                let fruits = try decoder.decode([ExoticFruit].self, from: data)
                print("Fetched \(fruits.count) fruits.")
                
                DispatchQueue.main.async {
                    completion(fruits)
                }
                
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
