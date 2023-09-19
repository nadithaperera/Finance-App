import SwiftUI
import Firebase

struct Category: Identifiable {
    var id: String?
    var name: String
    var color: String
}

struct CategoryView: View {
    @State private var isAlertShowing = false
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var newCategoryName: String = ""
    @State private var newCategoryColor: String = "green"
    @State private var Categories: [Category] = []

    var body: some View {
        VStack {
            Text("Categories")
                .fontWeight(.bold)
                .font(.title)
                .padding(.top, 10)
            List {
                ForEach(Categories) { category in
                    Text(category.name)
                }
            }
            Spacer()

            HStack(spacing: 16) {
                ZStack(alignment: .trailing) {
                    TextField("New Category", text: $newCategoryName)
                        .disableAutocorrection(true)
                        .padding(6)
                        .textFieldStyle(.roundedBorder)

                    if newCategoryName.count > 0 {
                        Button {
                            newCategoryName = ""
                        } label: {
                            Label("Clear input", systemImage: "xmark.circle.fill")
                                .labelStyle(.iconOnly)
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }
                }

                // You can use a Picker or ColorPicker for category color selection here

                Button {
                    if newCategoryName.count > 0 {
                        let newCategory = Category(id: nil, name: newCategoryName, color: newCategoryColor)
                        addCategoryToFirestore(category: newCategory)
                        newCategoryName = ""
                    } else {
                        isAlertShowing = true
                    }

                } label: {
                    Label("Submit", systemImage: "paperplane.fill")
                        .labelStyle(.iconOnly)
                        .padding(6)
                }
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(6)
                .alert("Must provide a category name!", isPresented: $isAlertShowing) {
                    Button("OK", role: .cancel) {
                        isAlertShowing = false
                    }
                }
            }
            .padding(.horizontal, 5)
        }
        .onAppear {
            loadCategoriesFromFirestore()
        }
    }

    func addCategoryToFirestore(category: Category) {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        guard let userUID = user?.uid else {
            print("User is not authenticated.")
            return
        }

        let userCategoriesRef = db.collection("users").document(userUID).collection("categories")

        let categoryData: [String: Any] = [
            "name": category.name,
            "color": category.color
        ]

        userCategoriesRef.addDocument(data: categoryData) { error in
            if let error = error {
                print("Error adding category: \(error.localizedDescription)")
            } else {
                print("Category added successfully to Firestore")
                loadCategoriesFromFirestore()
            }
        }
    }

    func loadCategoriesFromFirestore() {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        guard let userUID = user?.uid else {
            print("User is not authenticated.")
            return
        }

        let userCategoriesRef = db.collection("users").document(userUID).collection("categories")

        userCategoriesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching categories: \(error.localizedDescription)")
            } else {
                if let documents = snapshot?.documents {
                    Categories = documents.compactMap { document in
                        let data = document.data()
                        if let name = data["name"] as? String,
                           let color = data["color"] as? String {
                            return Category(id: document.documentID, name: name, color: color)
                        }
                        return nil
                    }
                }
            }
        }
    }
}
