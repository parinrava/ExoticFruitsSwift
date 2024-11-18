import SwiftUI

struct ExoticFruitDetailView: View {
    @ObservedObject var viewModel: ExoticFruitViewModel
    let fruit: ExoticFruit

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Fruit Image
                if let imageData = Data(base64Encoded: fruit.image),
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color("iconGreen"), lineWidth: 4)
                        )
                        .shadow(radius: 10)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 200, height: 200)
                        .overlay(
                            Circle().stroke(Color("iconGreen"), lineWidth: 4)
                        )
                        .shadow(radius: 10)
                        .overlay(
                            Text("No Image")
                                .font(.headline)
                                .foregroundColor(.white)
                        )
                }

                // Fruit Name
                Text(fruit.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("iconGreen"))

                // Fruit Description
                Text(fruit.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("backgroundColor").opacity(0.2))
                    )
                    .padding(.horizontal)

                // Countries Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Countries of Origin:")
                        .font(.headline)
                        .foregroundColor(Color("iconGreen"))

                    Text(fruit.countries.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("backgroundColor").opacity(0.2))
                )
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        .background(Color("backgroundColor").edgesIgnoringSafeArea(.all))
        .navigationTitle(fruit.name)
    }
}

// MARK: - Preview

struct ExoticFruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create mock data
        let mockFruit = ExoticFruit(
            id: 1,
            name: "Mango",
            description: "A tropical fruit that's sweet and delicious, known for its juicy flesh and vibrant flavor. Mangos are rich in vitamins and antioxidants, making them a popular choice in smoothies and desserts.",
            countries: ["India", "Mexico", "Philippines"],
            image: "" // Replace with a base64-encoded image string if available
        )
        let mockViewModel = ExoticFruitViewModel()

        return NavigationView {
            ExoticFruitDetailView(viewModel: mockViewModel, fruit: mockFruit)
        }
    }
}
