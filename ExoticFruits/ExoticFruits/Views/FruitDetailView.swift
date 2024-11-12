import SwiftUI

struct ExoticFruitDetailView: View {
    let fruit: ExoticFruit  // Accept a specific fruit

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            if let imageData = Data(base64Encoded: fruit.image),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 150)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            }

            Text(fruit.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text(fruit.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 20)
            
            Text("Countries: \(fruit.countries.joined(separator: ", "))")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
        }
        .padding()
        .navigationTitle("Exotic Fruit Details")
    }
}
