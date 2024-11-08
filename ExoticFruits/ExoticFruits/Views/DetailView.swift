//
//  DetailView.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

// Views/DetailView.swift

import SwiftUI

struct DetailView: View {
    var item: Item
    @EnvironmentObject var itemApi: ItemApi
    @State private var editedItem: Item
    
    init(item: Item) {
        self.item = item
        self._editedItem = State(initialValue: item)
    }

    var body: some View {
        VStack {
            TextField("Name", text: $editedItem.name)
            TextField("Description", text: $editedItem.description)
            Button("Save") {
                itemApi.updateItem(editedItem) { success in
                    if success {
                        print("Item updated")
                    } else {
                        print("Failed to update item")
                    }
                }
            }
        }
    }
}


//#Preview {
//    DetailView()
//}
