//
//  FruitDetailView.swift
//  ExoticFruits
//
//  Created by Parin Ravanbakhsh on 2024-11-08.
//

// Views/FruitDetailView.swift

import SwiftUI

struct FruitDetailView: View {
    var item: Item

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let imageData = Data(base64Encoded: item.imageBase64),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text(item.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Description")
                .font(.title2)
                .fontWeight(.semibold)
            Text(item.description)
                .font(.body)
            
            Text("Countries")
                .font(.title2)
                .fontWeight(.semibold)
            Text(item.countries.joined(separator: ", "))
                .font(.body)
        }
        .padding()
        .navigationTitle(item.name)
    }
}

#Preview {
    FruitDetailView(item: Item(id: UUID(), name: "Sample Fruit", description: "A tasty exotic fruit.", countries: ["Brazil", "Colombia"], imageBase64: ""))
}
