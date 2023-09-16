//
//  AuthVIewModel.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        print("Sign in...")
    }
    
    func createUser(withEmail email: String, fullname: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        }catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
            
    }
    
    func signOut() {
        print("Sign out...")
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUserData() async {
        
    }
}
