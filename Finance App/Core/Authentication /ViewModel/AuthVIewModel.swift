//
//  AuthVIewModel.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        print("Sign in...")
    }
    
    func createUser(withEmail email: String, fullname: String, password: String) async throws {
        print("Sign up...")
    }
    
    func signOut() {
        print("Sign out...")
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUserData() async {
        
    }
}
