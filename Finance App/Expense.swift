//
//  Expense.swift
//  Finance App
//
//  Created by Naditha on 2023-09-17.
//

import SwiftUI
import SwiftData

//@Model
class Expense {
    //Expense properties
    var title: String
    var Subtitle: String
    var amount: Double
    var date: Date
    
    init(title: String, Subtitle: String, amount: Double, date: Date) {
        self.title = title
        self.Subtitle = Subtitle
        self.amount = amount
        self.date = date
    }
}
