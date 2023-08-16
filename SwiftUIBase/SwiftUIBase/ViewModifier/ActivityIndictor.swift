//
//  ActivityIndictor.swift
//  ChatApp
//
//  Created by manjil on 23/02/2023.
//

import SwiftUI

struct ActivityIndictor: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                Color.gray.opacity(0.5)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(Color.black)
                    .frame(width: 100, height: 100)
                    .scaleEffect(2)
                    
            }
        }
    }
}
