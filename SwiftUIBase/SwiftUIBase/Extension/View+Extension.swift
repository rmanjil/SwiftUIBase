//
//  View+Extension.swift
//  ChatApp
//
//  Created by manjil on 23/02/2023.
//

import SwiftUI

extension View {
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var topSafeArea: CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return (keyWindow?.safeAreaInsets.top) ?? 0
    }
    
    func activityIndictor(isLoading: Binding<Bool>) -> some View {
        self.modifier(ActivityIndictor(isLoading: isLoading))
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
