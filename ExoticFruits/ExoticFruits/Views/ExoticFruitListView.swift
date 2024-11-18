import SwiftUI

struct ExoticFruitListView: View {
    @StateObject private var viewModel = ExoticFruitViewModel()
    @State private var showAddFruitForm = false
    @State private var showEditFruitForm = false
    @State private var selectedFruit: ExoticFruit?

    var body: some View {
        TabView {
            NavigationView {
                ZStack {
                    Color("backgroundColor")
                        .edgesIgnoringSafeArea(.all)
                        
                    

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

                            Button {
                                selectedFruit = fruit
                                showEditFruitForm = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                    
                    .scrollContentBackground(.hidden)
                }
                .navigationTitle("Exotic Fruits")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showAddFruitForm = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(Color("iconGreen"))
                        }
                        
                    }
                }
                .onAppear {
                    viewModel.fetchAllFruits()
                }
                .sheet(isPresented: $showAddFruitForm) {
                    AddFruitView()
                }
                .sheet(isPresented: $showEditFruitForm, onDismiss: {
                    selectedFruit = nil
                }) {
                    if let fruitToEdit = selectedFruit {
                        EditFruitView(fruit: fruitToEdit) { updatedFruit in
                            viewModel.updateFruit(updatedFruit) { success in
                                if success {
                                    viewModel.fetchAllFruits()
                                } else {
                                    viewModel.errorMessage = ErrorMessage(message: "Failed to update the fruit.")
                                }
                            }
                            showEditFruitForm = false
                        }
                    } else {
                        Text("Error: No fruit selected for editing.")
                    }
                }
                .alert(item: $viewModel.errorMessage) { errorMessage in
                    Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
                }
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            AboutUsView()
                .tabItem {
                    Label("About Us", systemImage: "info.circle")
                }
        }
    }
}

// MARK: - Preview

struct ExoticFruitListView_Previews: PreviewProvider {
    static var previews: some View {
        // Create mock view model
        let mockViewModel = ExoticFruitViewModel()
        mockViewModel.fruits = [
            ExoticFruit(
                id: 1,
                name: "Mango",
                description: "A tropical fruit that's sweet and delicious.",
                countries: ["India", "Mexico"],
                image: "" // Add a base64-encoded image string here if you want to test images
            ),
            ExoticFruit(
                id: 2,
                name: "Durian",
                description: "Known as the king of fruits, it has a strong smell.",
                countries: ["Malaysia", "Thailand"],
                image: "" // Add a base64-encoded image string here
            )
        ]

        return ExoticFruitListView()
            .environmentObject(mockViewModel) // Inject mock data
    }
}
