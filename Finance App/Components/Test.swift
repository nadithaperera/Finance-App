////
////  CategoryView.swift
////  Finance App
////
////  Created by Naditha on 2023-09-17.
////
//
//import SwiftUI
//
//struct CategoryView: View {
//    @State private var isAlertShowing = false
//    @EnvironmentObject var viewModel: AuthViewModel
//    @State private var newCategoryName: String = ""
//    @State private var newCategoryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
//    @State private var Categories: [Category] = [
//        Category(id: 0, name: "Groceries", Color: .green),
//        Category(id: 1, name: "Bills", Color: .blue),
//        Category(id: 2, name: "Subscriptions", Color: .red)
//    ]
//    var body: some View {
//        VStack {
//            List {
//                ForEach(Categories) {
//                    Category in
//                    HStack {
//                        Circle()
//                            .frame(width: 14, height: 14)
//                            .foregroundColor(Category.Color)
//                        Text(Category.name)
//                    }
//                }
//            }
//            Spacer()
//            
//            HStack (spacing: 16) {
//                ZStack (alignment: .trailing) {
//                    TextField("New Category", text: $newCategoryName)
//                        .disableAutocorrection(true)
//                        .padding(6)
//                        .textFieldStyle(.roundedBorder)
//                    
//                    if newCategoryName.count > 0{
//                        Button {
//                            newCategoryName = ""
//                        } label: {
//                            Label("Clear input", systemImage: "xmark.circle.fill")
//                                .labelStyle(.iconOnly)
//                                .foregroundColor(.gray)
//                                .padding(.trailing, 10)
//                        }
//                    }
//
//                }
//                
//                ColorPicker("", selection: $newCategoryColor)
//                    .labelsHidden()
//                
//                Button {
//                    if newCategoryName.count > 0 {
//                        Categories.append(Category(id: Categories.count,
//                                                   name: newCategoryName,
//                                                   Color: newCategoryColor))
//                        newCategoryName = ""
//                    }else {
//                        isAlertShowing = true
//                    }
//                    
//                } label: {
//                    Label("Submit", systemImage: "paperplane.fill")
//                        .labelStyle(.iconOnly)
//                        .padding(6)
//                }
//                .background(.blue)
//                .foregroundColor(.white)
//                .cornerRadius(6)
//                .alert("Must provide a category name!", isPresented: $isAlertShowing) {
//                    Button("OK", role: .cancel) {
//                        isAlertShowing = false
//                    }
//                }
//
//            }
//            .padding(.horizontal, 5)
//        }
//        
//        VStack {
//            Spacer()
//            NavigationView {
//                CustomTabBar()
//            }
//
//        }
//            //.navigationBarBackButtonHidden(true)
//    }
//}
//
//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
