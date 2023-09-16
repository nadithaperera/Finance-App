//
//  RegistrationView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack {
            Image("logo02-removebg-preview")
               .resizable()
               .scaledToFill()
               .frame(width: 300, height: 150)
               .padding(.vertical, 32)
            
            
            //formfeilds
            VStack(spacing: 24){
                inputView(text: $email,
                          title: "Email Address",
                          placeholder: "name@eExample.com")
                .autocapitalization(.none)
                
                inputView(text: $fullName,
                          title: "Full name",
                          placeholder: "Enter your name")
                
                inputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your password",
                          isSecureFeild: true)
                
                inputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeholder: "Confirm your password",
                          isSecureFeild: true)
            }
            .padding(.horizontal)
            .padding(.top, 14)
            
            Button {
                print("Sign user up..")
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top, 10)
            
            Spacer()
            
            Button {
            dismiss()
            } label: {
                HStack(spacing:3){
                    Text("Already have an account ?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }

        }
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
