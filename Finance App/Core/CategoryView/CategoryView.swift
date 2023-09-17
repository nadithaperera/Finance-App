//
//  CategoryView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-17.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var newCategoryName: String = ""
    @State private var newCategoryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    var body: some View {
        VStack {
            List {
                Text("Groceries")
                Text("Bills")
                Text("Subscriptions")
            }
            Spacer()
            
            HStack (spacing: 16) {
                ZStack (alignment: .trailing) {
                    TextField("New Category", text: $newCategoryName)
                        .disableAutocorrection(true)
                        .padding(6)
                        .textFieldStyle(.roundedBorder)
                    
                    if newCategoryName.count > 0{
                        Button {
                            newCategoryName = ""
                        } label: {
                            Label("Clear input", systemImage: "xmark.circle.fill")
                                .labelStyle(.iconOnly)
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }

                }
                
                ColorPicker("", selection: $newCategoryColor)
                    .labelsHidden()
                
                Button {
                    //action
                } label: {
                    Label("Submit", systemImage: "paperplane.fill")
                        .labelStyle(.iconOnly)
                        .padding(6)
                }
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(6)

            }
            .padding(.horizontal, 5)
        }
        
        VStack {
            Spacer()
            NavigationView {
                CustomTabBar()
            }

        }
            //.navigationBarBackButtonHidden(true)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
