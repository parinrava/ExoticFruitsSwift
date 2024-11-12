import SwiftUI

struct ExoticFruitDetailView: View {
    @ObservedObject var viewModel: ExoticFruitViewModel
    let fruit: ExoticFruit

    var body: some View {
        VStack {
            if let imageData = Data(base64Encoded: fruit.image),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            }
            Text(fruit.name)
                .font(.title)
                .fontWeight(.bold)
            Text(fruit.description)
                .font(.body)
                .multilineTextAlignment(.center)
            Text("Countries: \(fruit.countries.joined(separator: ", "))")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()
            
            Button(role: .destructive) {
                viewModel.deleteFruit(id: fruit.id)
            } label: {
                Text("Delete Fruit")
                    .foregroundColor(.red)
            }
            .padding()
        }
        .navigationTitle(fruit.name)
    }
}
