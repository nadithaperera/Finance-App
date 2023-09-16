//
//  Finance_AppApp.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI
import Firebase

@main
struct Finance_AppApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
