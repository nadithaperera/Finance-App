//
//  ReportView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-17.
//

import SwiftUI
import SwiftUICharts // Import the SwiftUICharts library

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

struct IncomeReportView: View {
    let transactions: [Transaction]
    
    var body: some View {
        VStack {
            BarChartView(data: ChartData(points: transactions.map { $0.amount }),
                         title: "Income",
                         legend: "Amount",
                         style: Styles.barChartStyleOrangeLight,
                         form: ChartForm.extraLarge)
                .padding()
            
            List(transactions, id: \.title) { transaction in
                HStack {
                    Text(transaction.title)
                    Spacer()
                    Text("$\(transaction.amount, specifier: "%.2f")")
                }
            }
        }
    }
}

struct ExpenseReportView: View {
    let transactions: [Transaction]
    
    var body: some View {
        VStack {
            BarChartView(data: ChartData(points: transactions.map { $0.amount }),
                         title: "Expenses",
                         legend: "Amount",
                         style: Styles.barChartStyleNeonBlueLight,
                         form: ChartForm.extraLarge)
                .padding()
            
            List(transactions, id: \.title) { transaction in
                HStack {
                    Text(transaction.title)
                    Spacer()
                    Text("$\(transaction.amount, specifier: "%.2f")")
                }
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
