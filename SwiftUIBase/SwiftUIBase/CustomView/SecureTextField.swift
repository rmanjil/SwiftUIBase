//
//  SecureTextField.swift
//  ChatApp
//
//  Created by manjil on 22/02/2023.
//

import SwiftUI

struct SecureTextField: View {
    let name: String
    let binder: Binding<String>
    @State private var isSecure  = true
    
    var body: some View {
        HStack {
            Group{
                if isSecure {
                    SecureField(name, text: binder, prompt: Text(name).foregroundColor(.gray))
                } else {
                    TextField(name, text: binder, prompt: Text(name).foregroundColor(.gray))
                }
            }
            Button(action: {
                self.isSecure.toggle()
            }) {
                Group {
                    if isSecure {
                        Image(systemName: "eye")
                        
                    } else {
                        Image(systemName: "eye.slash")
                    }
                }
                .padding(3)
               // .foregroundColor(.black)
            }
        }
    }
}
