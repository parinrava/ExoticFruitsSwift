//
//  ListView.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

// Views/ListView.swift

import SwiftUI

struct ListView: View {
    @EnvironmentObject var itemApi: ItemApi
    @State private var items = [Item]()

    var body: some View {
        List(items) { item in
            NavigationLink(destination: DetailView(item: item)) {
                VStack(alignment: .leading) {
                    Text(item.name).font(.headline)
                    Text(item.description).font(.subheadline)
                }
            }
        }
        .onAppear {
            itemApi.loadData { loadedItems in
                items = loadedItems
            }
        }
    }
}

#Preview {
    ListView()
}
