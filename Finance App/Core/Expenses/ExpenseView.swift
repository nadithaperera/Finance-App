import SwiftUI
import Firebase

struct Expense: Identifiable {
    var id: String?
    var amount: Double
    var date: Date
    var note: String
    var category: String
}

struct ExpenseView: View {
    @State private var searchText = ""
    @State private var selectedFilter = FilterType.thisMonth

    enum FilterType: String, CaseIterable {
        case today = "Today"
        case thisWeek = "This Week"
        case thisMonth = "This Month"
    }

    @State private var expenses: [Expense] = []

    var body: some View {
        VStack {
            Text("Expenses")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            HStack {
                TextField("Search expenses", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Picker("Filter", selection: $selectedFilter) {
                    ForEach(FilterType.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }

            List {
                ForEach(expenses) { expense in
                    VStack(alignment: .leading) {
                        Text("Amount: \(expense.amount)")
                        Text("Date: \(expense.date)")
                        Text("Note: \(expense.note)")
                        Text("Category: \(expense.category)")
                    }
                }
            }
        }
        .onAppear {
            fetchExpenses()
        }
    }

    func fetchExpenses() {
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser

        guard let userUID = user?.uid else {
            print("User is not authenticated.")
            return
        }

        let userExpensesRef = db.collection("users").document(userUID).collection("expenses") // Use "expenses" as the collection name

        // Placeholder implementation to fetch all expenses
        userExpensesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching expenses: \(error.localizedDescription)")
            } else {
                if let documents = snapshot?.documents {
                    self.expenses.removeAll()

                    for document in documents {
                        let data = document.data()
                        if let amount = data["amount"] as? Double,
                           let date = data["date"] as? Date,
                           let note = data["note"] as? String,
                           let category = data["category"] as? String {
                            let id = document.documentID
                            let expense = Expense(id: id, amount: amount, date: date, note: note, category: category)
                            self.expenses.append(expense)
                        }
                    }
                }
            }
        }
    }
}
