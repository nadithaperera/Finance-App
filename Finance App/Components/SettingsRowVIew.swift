//
//  SettingsRowVIew.swift
//  Finance App
//
//  Created by Naditha on 2023-09-16.
//

import SwiftUI

struct SettingsRowVIew: View {
    let imageName: String
    let title: String
    let tintColor: Color
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

struct SettingsRowVIew_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowVIew(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
    }
}
