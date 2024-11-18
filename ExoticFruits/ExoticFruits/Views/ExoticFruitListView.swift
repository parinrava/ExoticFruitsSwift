import SwiftUI

struct ExoticFruitListView: View {
    @StateObject private var viewModel = ExoticFruitViewModel()
    @State private var showAddFruitForm = false
    @State private var showEditFruitForm = false
    @State private var selectedFruit: ExoticFruit?

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
                    
                    Button {
                        selectedFruit = fruit
                        showEditFruitForm = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
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
            .sheet(isPresented: $showEditFruitForm) {
                if let selectedFruit = selectedFruit {
                    EditFruitView(fruit: selectedFruit) { updatedFruit in
                        viewModel.updateFruit(updatedFruit) { success in
                            if success {
                                viewModel.fetchAllFruits() // Refresh the list after editing
                            }
                        }
                        showEditFruitForm = false
                    }
                }
            }
            .alert(item: $viewModel.errorMessage) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}
