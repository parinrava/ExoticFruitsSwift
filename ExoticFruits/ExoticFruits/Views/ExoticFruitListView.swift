import SwiftUI

struct ExoticFruitListView: View {
    @StateObject private var viewModel = ExoticFruitViewModel()
    @State private var showAddFruitForm = false
    @State private var showEditFruitForm = false
    @State private var selectedFruit: ExoticFruit?

    var body: some View {
        TabView {
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
                            // Set selectedFruit and then present the sheet
                            selectedFruit = fruit
                            showEditFruitForm = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
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
                .sheet(isPresented: $showEditFruitForm, onDismiss: {
                    // Reset selectedFruit after dismissing the edit form
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
        .background(Color("backgroundColor"))
        .edgesIgnoringSafeArea(.all)
    }
}

