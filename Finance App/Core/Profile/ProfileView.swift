//
//  ProfileView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            Section{
                HStack{
                    Text("NP")
                        .font(.title)
                        .foregroundColor(Color(.white))
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                    
                    VStack (alignment: .leading, spacing: 4){
                        Text("Naditha Perera")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top,4)
                            
                        Text("naditha123@gmai.com")
                            .font(.footnote)
                            .accentColor(.gray)
                    }
                }
            }
            Section ("General") {
                HStack{
                    SettingsRowVIew(imageName: "gear",
                                    title: "Version",
                                    tintColor: Color(.systemGray))
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Section("Account") {
                Button {
                    print("Sign out..")
                } label: {
                    SettingsRowVIew(imageName: "arrow.left.circle.fill",
                                    title: "Sign Out",
                                    tintColor: .red)
                }
                
                Button {
                    print("Delete account..")
                } label: {
                    SettingsRowVIew(imageName: "xmark.circle.fill",
                                    title: "Delete Account",
                                    tintColor: .red)
                }

            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
