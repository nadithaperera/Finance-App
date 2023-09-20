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
    // Dummy data for testing
    let dummyExpenses: [Expense] = [
        Expense(id: "1", amount: 50.0, date: Date(), note: "Dinner", category: "Food"),
        Expense(id: "2", amount: 30.0, date: Date(), note: "Gasoline", category: "Transportation"),
        // Add more dummy expenses here
    ]

    @State private var expenses: [Expense] = []
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Expense Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .padding(.bottom, 10)

                TextField("Search Expenses", text: $searchText)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(16)

                List(expenses.filter {
                    searchText.isEmpty || $0.note.localizedCaseInsensitiveContains(searchText)
                }) { expense in
                    ExpenseRow(expense: expense)
                }
            }
            .navigationBarTitle("", displayMode: .large)
            .onAppear {
                // Load dummy data for testing
                expenses = dummyExpenses
            }
        }
        .padding(.vertical, 10)
    }
}

struct ExpenseRow: View {
    let expense: Expense

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Amount: Rs. \(String(format: "%.2f", expense.amount))")
                .font(.title2)
                .foregroundColor(.primary)

            Text("Date: \(formattedDate)")
                .font(.caption)
                .foregroundColor(.secondary)

            Text("Category: \(expense.category)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }

    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: expense.date)
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
    }
}
