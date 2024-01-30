//
//  BorderedTextFieldView.swift
//  MyWidgets
//
//  Created by 许辉 on 2024/1/30.
//

import SwiftUI

struct BorderedTextFieldView: View {
    @Binding var text: String
    private let placeholder: String
    private let font: Font
    private let isSecure: Bool
    
    @State private var showPressed = false
    @FocusState private var isFocused: Bool
    
    
    init(text: Binding<String>, placeholder: String = "", font: Font = .body, isSecure: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.font = font
        self.isSecure = isSecure
    }
    
    var body: some View {
        textFieldView
            .animation(.smooth, value: isFocused)
    }
    
    private var textFieldView: some View {
        ZStack {
            VStack(alignment: .leading) {
                if isSecure, !showPressed {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .font(font)
            .focused($isFocused)
            .padding()
            .padding(.trailing, isSecure ? 30 : 0) // 防止密码过长显示不下
            .overlay {
                outlineView
            }
            showHiddenButtonView
        }
    }
    
    //MARK: - 边框
    private var outlineView: some View {
        ZStack(alignment: .leading, content: {
            RoundedRectangle(cornerRadius: 8.0)
                .stroke((isFocused || text.count > 0) ? Color.primary : Color.gray,
                        lineWidth: (isFocused || text.count > 0) ? 1.0 : 0.5)
            tagView
        })
    }
    //MARK: - 密码隐藏/显示按钮
    private var showHiddenButtonView: some View {
        ZStack {
            if isSecure {
                HStack {
                    Spacer()
                    Button{
                        showPressed.toggle()
                    } label: {
                        Text(showPressed ? "Hide" : "Show")
                            .font(.footnote)
                            .padding(4)
                            .background(Color.secondary)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                .padding(.trailing,8)
            }
        }
    }
    //MARK: - 输入框左上角提示
    private var tagView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(placeholder)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .padding(.horizontal, 3)
                    .foregroundStyle(.primary.opacity(0.5))
                    .background(Color(uiColor: .systemBackground))
                    .offset(y:text.isEmpty ? 0 : -8) // 有内容时向上偏移
                    .opacity(text.isEmpty ? 0 : 1.0) // 有内容时才显示此提示
                    .animation(.bouncy, value: text.count > 0)
            }
            .padding(.horizontal, 10)
            Spacer()
        }
    }
}

#Preview {
    VStack(spacing: 25, content: {
        BorderedTextFieldView(text: .constant("username"),placeholder: "Name",isSecure: false)
        BorderedTextFieldView(text: .constant("123456"),placeholder: "Password",isSecure: true)
    })
    .padding()
}
