//
//  EditFruitView.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-11.
//

import SwiftUI

struct EditFruitView: View {
    @State private var name: String
    @State private var description: String
    @State private var countries: String  // We'll handle this as a comma-separated list for simplicity.
    
    let fruit: ExoticFruit
    let onSave: (ExoticFruit) -> Void  // Callback to handle saving changes.

    init(fruit: ExoticFruit, onSave: @escaping (ExoticFruit) -> Void) {
        self.fruit = fruit
        self.onSave = onSave
        _name = State(initialValue: fruit.name)
        _description = State(initialValue: fruit.description)
        _countries = State(initialValue: fruit.countries.joined(separator: ", "))
    }

    var body: some View {
        Form {
            Section(header: Text("Fruit Details")) {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                TextField("Countries (comma-separated)", text: $countries)
            }
            
            Button(action: saveChanges) {
                Text("Save Changes")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Edit Fruit")
    }

    private func saveChanges() {
        let updatedFruit = ExoticFruit(
            id: fruit.id,
            name: name,
            description: description,
            countries: countries.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
            image: fruit.image
        )
        onSave(updatedFruit)
    }
}
