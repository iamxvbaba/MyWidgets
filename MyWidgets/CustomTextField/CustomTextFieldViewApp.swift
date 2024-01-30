//
//  CustomTextFieldViewApp.swift
//  MyWidgets
//
//  Created by 许辉 on 2024/1/30.
//

import SwiftUI

struct CustomTextFieldViewApp: View {
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        VStack(spacing: 25, content: {
            BorderedTextFieldView(text: $username,placeholder: "Name",isSecure: false)
            BorderedTextFieldView(text: $password,placeholder: "Password",isSecure: true)
        })
        .padding()
    }
}

#Preview {
    CustomTextFieldViewApp()
}
