//
//  LoginView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

struct LoginView: View {
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
                
                //sign in button
                Spacer()
                //sign up button
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
