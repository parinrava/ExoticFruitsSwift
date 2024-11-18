import SwiftUI

struct AddFruitView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var countries: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Fruit Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Countries (comma-separated)", text: $countries)
                }
                
                Section(header: Text("Image")) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    } else {
                        Button("Select Image") {
                            isImagePickerPresented = true
                        }
                    }
                }
                
                Button("Add Fruit") {
                    addFruit()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("New Fruit")
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
            }
        }
    }

    func addFruit() {
        guard let selectedImage = selectedImage else {
            print("No image selected.")
            return
        }

        let base64String = selectedImage.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
        let newFruit = ExoticFruit(id: 0, name: name, description: description, countries: countries.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }, image: base64String)
        
        // Call the API to create the fruit
        ExoticFruitApi().createFruit(newFruit) { success in
            if success {
                print("Fruit created successfully.")
            } else {
                print("Failed to create fruit.")
            }
        }
    }
}

struct AddFruitView_Previews: PreviewProvider {
    static var previews: some View {
        AddFruitView()
    }
}
