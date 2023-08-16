//
//  CustomText.swift
//  ChatApp
//
//  Created by manjil on 22/02/2023.
//

import SwiftUI

struct CustomText: View {
    let title: String
    let isSecure: Bool
    let contentType: UITextContentType?
    @ObservedObject var model: TextModel
    
    var body: some View {
        Group {
            HStack {
                Color.white.frame(width: 2)
                if isSecure {
                    SecureTextField(name: title, binder: $model.value)
                } else  {
                    TextField(title, text: $model.value, prompt: Text(title).foregroundColor(.gray)).textContentType(contentType)
                }
            }
        }
        .foregroundColor(.black)
        .frame( height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
        })
        .textFieldStyle(.plain)
    }
    
    init(title: String, isSecure: Bool = false, binder: TextModel, contentType: UITextContentType? = nil  ) {
        self.title = title.uppercased()
        self.isSecure = isSecure
        self.model = binder
        self.contentType = contentType
    }
}
