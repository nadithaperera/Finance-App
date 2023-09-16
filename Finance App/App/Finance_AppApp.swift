//
//  Finance_AppApp.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

@main
struct Finance_AppApp: App {
    @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
