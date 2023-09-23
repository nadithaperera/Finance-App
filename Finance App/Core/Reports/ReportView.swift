import SwiftUI
import SwiftUICharts
import Firebase
import FirebaseFirestore

struct Transaction {
    var note: String
    var amount: Double
}

struct ReportView: View {
    @State private var selectedReportIndex = 0
    
    @State private var incomeTransactions: [Transaction] = [
        Transaction(note: "Salary", amount: 2500.0),
        Transaction(note: "Freelance Work", amount: 1200.0)
    ]
    
    @State private var expenseTransactions: [Transaction] = [] // Add an @State property for expenses
    
    var body: some View {
        ScrollView {
            VStack {
                Picker("Select Report", selection: $selectedReportIndex) {
                    Text("Income Report").tag(0)
                    Text("Expense Report").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedReportIndex == 0 {
                    IncomeReportView(transactions: $incomeTransactions)
                } else {
                    ExpenseReportView(transactions: expenseTransactions) // Pass the expenses data
                }
            }
            .navigationTitle("Reports")
            .onAppear {
                fetchExpenses() // Fetch expenses when the view appears
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
                return
            } else if let documents = snapshot?.documents {
                self.expenseTransactions = documents.compactMap { document in
                    let data = document.data()
                    if let amount = data["amount"] as? Double,
                       let note = data["note"] as? String { // Change "title" to "note"
                        return Transaction(note: note, amount: amount) // Change the order of parameters
                    } else {
                        print("Invalid expense data in document: \(document.documentID)")
                        return nil
                    }
                }
                print("Expenses loaded successfully: \(self.expenseTransactions)")
            } else {
                print("No expenses found.")
            }
        }
    }
}

struct IncomeReportView: View {
    @State private var isAddingIncome = false
    @State private var newIncomeTitle = ""
    @State private var newIncomeAmount = ""
    
    @Binding var transactions: [Transaction] // Add a binding to transactions
    
    var body: some View {
        ScrollView { // Make the view scrollable
            VStack {
                LineView(data: transactions.map { $0.amount },
                         title: "Income Over Time",
                         legend: "Legend")
                .frame(width: 300, height: 500)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
                
                // Remove PieChartView here
                
                List(transactions, id: \.note) { transaction in
                    HStack {
                        Text(transaction.note)
                        Spacer()
                        Text("$\(transaction.amount, specifier: "%.2f")")
                    }
                }
                .animation(.easeInOut)
                
                HStack {
                    Button(action: {
                        isAddingIncome = true
                    }) {
                        Text("Add Income")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    // Button to delete all income transactions
                    Button(action: {
                        transactions.removeAll() // Delete all income transactions
                    }) {
                        Text("Delete Income")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                
                .sheet(isPresented: $isAddingIncome) {
                    NavigationView {
                        Form {
                            Section(header: Text("Add Income")) {
                                TextField("Enter Income Title", text: $newIncomeTitle)
                                TextField("Enter Income Amount", text: $newIncomeAmount)
                            }
                            
                            Section {
                                Button("ADD") {
                                    if let amount = Double(newIncomeAmount) {
                                        transactions.append(Transaction(note: newIncomeTitle, amount: amount)) // Use 'self' to modify the binding
                                        isAddingIncome = false // Dismiss the sheet
                                    }
                                }
                                
                            }
                        }
                        .navigationTitle("Add Income")
                        .navigationBarItems(trailing: Button("Cancel") {
                            isAddingIncome = false // Cancel adding income
                        })
                    }
                }
            }
        }
    }
}

struct ExpenseReportView: View {
    let transactions: [Transaction]
    
    var body: some View {
        ScrollView { // Make the view scrollable
            VStack {
                if !transactions.isEmpty { // Only display the chart when there is data
                    LineView(data: transactions.map { $0.amount },
                             title: "Expenses Over Time",
                             legend: "Legend")
                    .frame(width: 300, height: 500)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
                
                // Remove PieChartView here
                
                List(transactions, id: \.note) { transaction in
                    HStack {
                        Text(transaction.note)
                        Spacer()
                        Text("$\(transaction.amount, specifier: "%.2f")")
                    }
                }
                .animation(.easeInOut)
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
