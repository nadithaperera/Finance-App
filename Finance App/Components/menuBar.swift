//
//  menuBar.swift
//  Finance App
//
//  Created by Naditha on 2023-09-17.
//

import SwiftUI

struct menuBar: View {
    let imageNameExpense: String
    let imageNameReport: String
    let imageNameProfileView: String
    let imageNameAdd: String
    let titleExpense: String
    let titleAdd: String
    let titleReport: String
    let titleProfileView: String
    var body: some View {
        
        
    }
}

struct menuBar_Previews: PreviewProvider {
    static var previews: some View {
        menuBar(imageNameExpense: "tray.and.arrow.up.fill",
                imageNameReport: "chart.bar.fill",
                imageNameProfileView: "person.circle.fill",
                imageNameAdd: "plus.app",
                titleExpense: "Expense",
                titleAdd: "Add",
                titleReport: "Report",
                titleProfileView: "Profile")
    }
}
