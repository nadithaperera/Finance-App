//
//  LoginView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        NavigationStack {
            VStack{
                //img
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
                    
                    inputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureFeild: true)
                }
                .padding(.horizontal)
                .padding(.top, 14)
                
                //Forget Password
                NavigationLink {
                    
                } label: {
                    Text("Forgot Password")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                }
                .padding(.top, 10)

                //sign in button
                Button {
                    print("Log user in..")
                } label: {
                    HStack {
                        Text("SIGN IN")
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
                //sign up button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing:3){
                        Text("Dont have an account ?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }

                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
