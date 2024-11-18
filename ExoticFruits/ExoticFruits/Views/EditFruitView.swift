import SwiftUI
import PhotosUI

struct EditFruitView: View {
    @State private var name: String
    @State private var description: String
    @State private var countries: String  // Comma-separated list for simplicity.
    @State private var selectedImage: UIImage?  // Stores the selected image.
    @State private var imagePickerPresented = false
    
    let fruit: ExoticFruit
    let onSave: (ExoticFruit) -> Void  // Callback to handle saving changes.

    init(fruit: ExoticFruit, onSave: @escaping (ExoticFruit) -> Void) {
        self.fruit = fruit
        self.onSave = onSave
        _name = State(initialValue: fruit.name)
        _description = State(initialValue: fruit.description)
        _countries = State(initialValue: fruit.countries.joined(separator: ", "))
        _selectedImage = State(initialValue: {
            if let imageData = Data(base64Encoded: fruit.image) {
                return UIImage(data: imageData)
            } else {
                return nil
            }
        }())
    }

    var body: some View {
        Form {
            Section(header: Text("Fruit Details")) {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                TextField("Countries (comma-separated)", text: $countries)
            }
            
            Section(header: Text("Fruit Image")) {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(8)
                        .padding(.vertical)
                } else {
                    Text("No image selected")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                Button(action: {
                    imagePickerPresented = true
                }) {
                    Text("Select Image")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }

            Button(action: saveChanges) {
                Text("Save Changes")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Edit Fruit")
        .sheet(isPresented: $imagePickerPresented) {
            ImagePicker(
                selectedImage: $selectedImage,
                isPresented: $imagePickerPresented,
                sourceType: .photoLibrary // You can also use .camera if needed
            )
        }

    }

    private func saveChanges() {
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        let base64Image = imageData?.base64EncodedString() ?? fruit.image  // Use the existing image if no new image is selected

        let updatedFruit = ExoticFruit(
            id: fruit.id,
            name: name,
            description: description,
            countries: countries.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
            image: base64Image
        )
        onSave(updatedFruit)
    }
}

// MARK: - Preview
struct EditFruitView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFruit = ExoticFruit(
            id: 1,
            name: "Mango",
            description: "A sweet tropical fruit",
            countries: ["India", "Philippines"],
            image: "" // Add a base64 image string here if you want to preview with an image
        )
        
        EditFruitView(fruit: sampleFruit) { updatedFruit in
            print("Updated Fruit: \(updatedFruit)")
        }
    }
}
