//
//  View+Extension.swift
//  ChatApp
//
//  Created by manjil on 23/02/2023.
//

import SwiftUI

extension View {
    
    func activityIndictor(isLoading: Binding<Bool>) -> some View {
        self.modifier(ActivityIndictor(isLoading: isLoading))
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
