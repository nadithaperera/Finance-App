////
//  ContentView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedTab: Tabs = .expense
    var body: some View {
        if viewModel.userSession != nil {
            TabView(selection: $selectedTab) {
                ExpenseView()
                    .tabItem {
                        Label("Expense", systemImage: "tray.and.arrow.up.fill")
                    }
                    .tag(Tabs.expense)
                
                ReportView()
                    .tabItem {
                        Label("Report", systemImage: "chart.bar.fill")
                    }
                    .tag(Tabs.report)
                
                AddView()
                    .tabItem {
                        Label("Add", systemImage: "plus.circle.fill")
                    }
                    .tag(Tabs.add)
                
                CategoryView()
                    .tabItem {
                        Label("Category", systemImage: "list.clipboard.fill")
                    }
                    .tag(Tabs.category)
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .tag(Tabs.profile)
            }
            .accentColor(.blue) // Set the tab bar color
            
            //CustomTabBar(selectedTabs: $selectedTab)
        } else {
            LoginView()
        } 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
