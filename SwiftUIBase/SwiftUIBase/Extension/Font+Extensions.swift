//
//  Font+Extensions.swift
//  KFCSWIFTUI
//
//  Created by ekmacmini37 on 16/02/2023.
//

import Foundation
import SwiftUI

extension Font {
    
    enum State {
        case regular,
             medium,
             semiBold,
             bold,
             custom(name: String)
        
        var value: String {
            switch self {
            case .regular, .medium, .semiBold, .bold:
                return ""
            case .custom(let name):
                return name
            }
        }
    }
    
    static func custom(_ type: State, size: CGFloat = 12) -> Font {
        return .custom(type.value, size: size)
    }
    
}
