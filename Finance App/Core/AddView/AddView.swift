import SwiftUI
import Firebase

struct ExpenseCategory: Identifiable, Hashable {
    var id: String?
    var name: String
}

struct AddView: View {
    @State private var isAlertShowing = false
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectedCategory: ExpenseCategory? = nil
//    @State private var Categories: [ExpenseCategory] = []
    @State private var categories: [ExpenseCategory] = []
    // Placeholder variables (replace with your actual variables)
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var note: String = ""

    var body: some View {
        VStack {
            Text("Add Expenses")
                .fontWeight(.bold)
                .font(.title)
                .padding(.top, 10)
            List {
                HStack {
                    Text("Amount")
                    Spacer()
                    TextField("Amount", text: $amount)
                        .multilineTextAlignment(.trailing)
                        .submitLabel(.done)
                        .keyboardType(.numberPad)
                }

                HStack {
                    Text("Date")
                    Spacer()
                    DatePicker(
                        selection: $date,
                        in: Date()...,
                        displayedComponents: .date,
                        label: { Text("") }
                    )
                }

                HStack {
                    Text("Note")
                    Spacer()
                    TextField("Note", text: $note)
                        .multilineTextAlignment(.trailing)
                        .submitLabel(.done)
                }

                HStack {
                                    Text("Category")
                                    Spacer()
                                    Picker("Select Category", selection: $selectedCategory) {
                                        ForEach(categories) { category in
                                            Text(category.name).tag(category)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle()) // Use MenuPickerStyle for a dropdown appearance
                                }
                            }
                            .scrollDisabled(true)
                            .frame(height: 275)
                            .padding(.top, 10)

            Button {
                // Placeholder function (replace with your actual logic)
                handleCreate()
            } label: {
                Label("Submit expense", systemImage: "plus")
                    .labelStyle(.titleOnly)
                    .padding(.horizontal, 44)
                    .padding(.vertical, 12)
            }
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)

            Spacer()
        }
        .onAppear {
            // Fetch categories from Firestore
            loadCategoriesFromFirestore()
        }
    }

    // Placeholder function to fetch categories from Firestore
    func loadCategoriesFromFirestore() {
        // Your Firestore fetching logic here
        // Update the Categories array with fetched categories
    }

    // Placeholder function for handling expense creation
    func handleCreate() {
        // Your logic for creating an expense here
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
