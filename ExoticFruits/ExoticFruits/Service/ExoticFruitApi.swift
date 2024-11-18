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
    
    func createFruit(_ fruit: ExoticFruit, completion: @escaping (Bool) -> Void) {
           guard let url = URL(string: "https://dotneta2v3-fbhwd5bfcffxd3fx.westus-01.azurewebsites.net/api/ExoticFruit/Create") else {
               print("Invalid URL.")
               completion(false)
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
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
                   print("Error creating data: \(error.localizedDescription)")
                   completion(false)
                   return
               }

               if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                   completion(true)
               } else {
                   print("Server responded with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                   completion(false)
               }
           }
           task.resume()
       }
    
    // Delete function to remove a fruit by id
    func deleteFruit(id: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://dotneta2v3-fbhwd5bfcffxd3fx.westus-01.azurewebsites.net/api/ExoticFruit/Delete/\(id)") else {
            print("Invalid URL.")
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting data: \(error.localizedDescription)")
                completion(false)
                return
            }

            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                completion(true)
            } else {
                print("Server responded with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                completion(false)
            }
        }
        task.resume()
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
            completion(true)
        }
        task.resume()
    }
}
