import SwiftUI

struct ExoticFruitListView: View {
    @StateObject private var viewModel = ExoticFruitViewModel()
    @State private var showAddFruitForm = false

    var body: some View {
        NavigationView {
            List(viewModel.fruits) { fruit in
                NavigationLink(destination: ExoticFruitDetailView(viewModel: viewModel, fruit: fruit)) {
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
                            Text(fruit.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.deleteFruit(id: fruit.id)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Exotic Fruits")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddFruitForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.fetchAllFruits()
            }
            .sheet(isPresented: $showAddFruitForm) {
                AddFruitView()
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}
