////
////  CustomTabBar.swift
////  Finance App
////
////  Created by Naditha on 2023-09-17.
////
//
//import SwiftUI
//
//struct CustomTabBar: View {
//    @EnvironmentObject var viewModel: AuthViewModel
//    var body: some View {
//
//        HStack (spacing: 30) {
//
//            Button {
//                // destination
//            } label: {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "tray.and.arrow.up.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Expense")
//                        .font(Font.footnote)
//
//                }
//            }
//
//            Button {
//                //switch to class
//            } label: {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "chart.bar.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Report")
//                        .font(Font.footnote)
//
//                }
//            }
//
//            Button {
//                //switch to class
//            } label: {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "plus.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Add")
//                        .font(Font.footnote)
//
//                }
//            }
//
//            Button {
//                //switch to class
//            } label: {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "list.clipboard.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Category")
//                        .font(Font.footnote)
//
//                }
//            }
//
//            Button {
//                //switch to class
//            } label: {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "person.crop.circle")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Profile")
//                        .font(Font.footnote)
//
//                }
//            }
//
//
//        }
//        .frame(height: 82)
//
//    }
//}
//
//struct CustomTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTabBar()
//    }
//}
