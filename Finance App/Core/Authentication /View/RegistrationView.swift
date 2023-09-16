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
    @EnvironmentObject var viewModel: AuthViewModel
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
                
                ZStack(alignment: .trailing) {
                    inputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm your password",
                              isSecureFeild: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword{
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        }else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 14)
            
            Button {
                Task {
                   try await viewModel.createUser(withEmail: email,
                                                  fullname:fullName,
                                                  password:password)
                }
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
            .disabled(!formIsVaild)
            .opacity(formIsVaild ? 1.0 : 0.5)
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

//Authentication Form Protocol
extension RegistrationView: AuthenticationFormProtocol {
    var formIsVaild: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
    
    struct RegistrationView_Previews: PreviewProvider {
        static var previews: some View {
            RegistrationView()
        }
    }
}
