//
//  FormView.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

import SwiftUI

struct FormView: View {
    @EnvironmentObject var itemApi: ItemApi
    @State private var newItem = Item(id: UUID(), name: "", description: "", countries: [], imageBase64: "")

    var body: some View {
        VStack {
            TextField("Name", text: $newItem.name)
            TextField("Description", text: $newItem.description)
            Button("Add Item") {
                itemApi.createItem(newItem) { success in
                    if success {
                        print("Item created")
                    } else {
                        print("Failed to create item")
                    }
                }
            }
        }
    }
}


#Preview {
    FormView()
}
