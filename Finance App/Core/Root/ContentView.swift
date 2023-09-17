////
//  ContentView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                //ProfileView()
                ExpenseView()
//                VStack {
//                    Spacer()
//                    CustomTabBar()
//                }

            } else {
                LoginView()
                //Expenses()

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
