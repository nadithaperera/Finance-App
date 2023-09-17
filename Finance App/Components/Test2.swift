//import SwiftUI
//
//struct CustomTabBar: View {
//    @EnvironmentObject var viewModel: AuthViewModel
//    
//    var body: some View {
//        HStack (spacing: 30) {
//            
//            NavigationLink(destination: ExpenseView()) {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "tray.and.arrow.up.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Expense")
//                        .font(Font.footnote)
//                }
//            }
//            
//            NavigationLink(destination: ReportView()) {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "chart.bar.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Report")
//                        .font(Font.footnote)
//                }
//            }
//            
//            NavigationLink(destination: AddView()) {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "plus.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Add")
//                        .font(Font.footnote)
//                }
//            }
//            
//            NavigationLink(destination: CategoryView()) {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "list.clipboard.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Category")
//                        .font(Font.footnote)
//                }
//            }
//            
//            NavigationLink(destination: ProfileView()) {
//                VStack (alignment: .center, spacing: 4) {
//                    Image(systemName: "person.crop.circle")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                    Text("Profile")
//                        .font(Font.footnote)
//                }
//            }
//        }
//        .frame(height: 82)
//    }
//}
//
//struct CustomTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTabBar()
//    }
//}
