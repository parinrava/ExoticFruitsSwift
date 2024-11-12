import SwiftUI

struct ExoticFruitListView: View {
    @StateObject private var viewModel = ExoticFruitViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.fruits.isEmpty {
                    Text("No fruits available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.fruits) { fruit in
                        NavigationLink(destination: ExoticFruitDetailView(fruit: fruit)) {
                            HStack {
                                if let imageData = Data(base64Encoded: fruit.image),
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else {
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 50, height: 50)
                                }

                                VStack(alignment: .leading) {
                                    Text(fruit.name)
                                        .font(.headline)
                                    Text("Countries: \(fruit.countries.joined(separator: ", "))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Exotic Fruits")
            .onAppear {
                viewModel.fetchAllFruits()
                print("Fetching all fruits...")
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}
