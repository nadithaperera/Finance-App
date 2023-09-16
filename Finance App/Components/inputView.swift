//
//  inputView.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

struct inputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureFeild = false
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Text (title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureFeild  {
                SecureField(placeholder,text: $text)
                    .font(.system(size: 14))
            } else  {
                TextField(placeholder,text: $text)
                    .font(.system(size: 14))
            }
            
            Divider()
        }
    }
}

struct inputView_Previews: PreviewProvider {
    static var previews: some View {
        inputView(text:.constant(""), title: "Email Address", placeholder: "Name@example.com")
    }
}
