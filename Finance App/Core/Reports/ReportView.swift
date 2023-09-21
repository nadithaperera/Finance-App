import SwiftUI
import SwiftUICharts

struct Transaction {
    var title: String
    var amount: Double
}

struct ReportView: View {
    @State private var selectedReportIndex = 0
    
    let incomeTransactions: [Transaction] = [
        Transaction(title: "Salary", amount: 2500.0),
        Transaction(title: "Freelance Work", amount: 1200.0),
        // Add more income transactions as needed
    ]
    
    let expenseTransactions: [Transaction] = [
        Transaction(title: "Groceries", amount: 300.0),
        Transaction(title: "Rent", amount: 1200.0),
        // Add more expense transactions as needed
    ]
    
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
                    IncomeReportView(transactions: incomeTransactions)
                } else {
                    ExpenseReportView(transactions: expenseTransactions)
                }
            }
            .navigationTitle("Reports")
        }
    }
}

struct IncomeReportView: View {
    let transactions: [Transaction]

    var body: some View {
        VStack {
            LineView(data: transactions.map { $0.amount },
                     title: "Income Over Time",
                     legend: "Legend")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)

            PieChartView(data: transactions.map { $0.amount },
                         title: "Income Distribution",
                         legend: "Legend")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)

            List(transactions, id: \.title) { transaction in
                HStack {
                    Text(transaction.title)
                    Spacer()
                    Text("$\(transaction.amount, specifier: "%.2f")")
                }
            }
            .animation(.easeInOut)
        }
    }
}

struct ExpenseReportView: View {
    let transactions: [Transaction]

    var body: some View {
        VStack {
            LineView(data: transactions.map { $0.amount },
                     title: "Expenses Over Time",
                     legend: "Legend")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)

            PieChartView(data: transactions.map { $0.amount },
                         title: "Expense Distribution",
                         legend: "Legend")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)

            List(transactions, id: \.title) { transaction in
                HStack {
                    Text(transaction.title)
                    Spacer()
                    Text("$\(transaction.amount, specifier: "%.2f")")
                }
            }
            .animation(.easeInOut)
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
