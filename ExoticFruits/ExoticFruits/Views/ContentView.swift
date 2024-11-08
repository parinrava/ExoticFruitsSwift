//
//  ContentView.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

// ContentView.swift

// ContentView.swift

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var itemApi: ItemApi
    @State private var items: [Item] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: FruitDetailView(item: item)) {
                        HStack {
                            if let imageData = Data(base64Encoded: item.imageBase64),
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Circle().frame(width: 50, height: 50).foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Exotic Fruits")
            .onAppear {
                itemApi.loadData { fetchedItems in
                    items = fetchedItems
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ItemApi()) // Injecting the ItemApi instance
}
