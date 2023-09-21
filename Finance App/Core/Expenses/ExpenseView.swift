import SwiftUI
import Firebase
import FirebaseFirestore

struct Category_: Identifiable, Hashable {
    var id: String?
    var name: String
    var color: String // Include a placeholder color
    static let all = Category_(id: nil, name: "All", color: "PlaceholderColor")

}

struct Expense: Identifiable {
    var id: String?
    var amount: Double
    var date: Date
    var note: String
    var category: String
}

struct ExpenseView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var expenses: [Expense] = []
    @State private var categories: [Category_] = []
    @State private var searchText = ""
    @State private var selectedCategoryIndex = 0
    @State private var selectedTimeFrameIndex = 0
    
    let timeFrameOptions = ["This Week", "This Month", "This Year"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Expenses")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                // Time Frame Picker
                Picker("Select a Time Frame", selection: $selectedTimeFrameIndex) {
                    ForEach(0..<timeFrameOptions.count, id: \.self) { index in
                        Text(timeFrameOptions[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(10)
                
                // Category Picker
                HStack {
                    Text("Category:")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.trailing, 10)
                    
                    Picker("", selection: $selectedCategoryIndex) {
                        ForEach(0..<categories.count, id: \.self) { index in
                            Text(categories[index].name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                }
                .onChange(of: selectedCategoryIndex) { newValue in
                    // Handle the selection change here
                    // You can update the selectedCategory or perform any other actions
                    let selectedCategory = categories[newValue]
                    
                    if selectedCategory == Category_.all {
                        // User selected "All," so display all expenses (you may need to reload data)
                        fetchExpenses() // You may need to implement this function to fetch all expenses
                    } 
                }
                    
                    TextField("Search Expenses", text: $searchText)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                    
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(filteredExpenses) { expense in
                                ExpenseRow(expense: expense)
                                    .frame(maxWidth: .infinity)
                                    .padding(16)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .navigationBarTitle("", displayMode: .large)
                .onAppear {
                    loadCategoriesFromFirestore()
                    fetchExpenses()
                }
            }
            .padding(.vertical, 10)
        }
        
        var filteredExpenses: [Expense] {
            var filteredExpenses = expenses
            
            // Filter by Category
            if selectedCategoryIndex < categories.count {
                let selectedCategory = categories[selectedCategoryIndex].name
                filteredExpenses = filteredExpenses.filter { $0.category == selectedCategory }
            }
            
            // Filter by time frame
            switch timeFrameOptions[selectedTimeFrameIndex] {
            case "This Week":
                let startDate = Calendar.current.startOfDay(for: Date())
                filteredExpenses = filteredExpenses.filter { Calendar.current.isDate($0.date, inSameDayAs: startDate) }
            case "This Month":
                let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
                let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
                filteredExpenses = filteredExpenses.filter { $0.date >= startOfMonth && $0.date <= endOfMonth }
            case "This Year":
                let startOfYear = Calendar.current.date(from: Calendar.current.dateComponents([.year], from: Date()))!
                let endOfYear = Calendar.current.date(byAdding: DateComponents(year: 1, day: -1), to: startOfYear)!
                filteredExpenses = filteredExpenses.filter { $0.date >= startOfYear && $0.date <= endOfYear }
            default:
                break
            }
            
            return filteredExpenses
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
                        self.categories = documents.compactMap { document in
                            let data = document.data()
                            if let name = data["name"] as? String,
                               let color = data["color"] as? String {
                                return Category_(id: document.documentID, name: name, color: color)
                            }
                            return nil
                        }
                        print("Categories loaded successfully: \(self.categories)")
                    }
                }
            }
        }
        
        func fetchExpenses() {
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            
            guard let userUID = user?.uid else {
                print("User is not authenticated.")
                return
            }
            
            let expensesRef = db.collection("users").document(userUID).collection("expenses")
            
            expensesRef.getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching expenses: \(error.localizedDescription)")
                } else {
                    if let documents = snapshot?.documents {
                        self.expenses = documents.compactMap { document in
                            let data = document.data()
                            if let amount = data["amount"] as? Double,
                               let dateTimestamp = data["date"] as? Timestamp,
                               let note = data["note"] as? String,
                               let category = data["category"] as? String {
                                let date = dateTimestamp.dateValue()
                                return Expense(id: document.documentID, amount: amount, date: date, note: note, category: category)
                            }
                            return nil
                        }
                        print("Expenses loaded successfully: \(self.expenses)")
                    }
                }
            }
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
        }
        
        var formattedDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: expense.date)
        }
    }
