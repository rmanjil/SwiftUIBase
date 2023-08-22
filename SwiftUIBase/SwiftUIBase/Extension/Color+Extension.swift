//
//  Color+Extension.swift
//  SwiftUIBase
//
//  Created by manjil on 22/08/2023.
//

import SwiftUI

extension Color {
    
    private static func named(_ colorName: String) -> Color {
        return Color(colorName)
    }
    
    static let background = Color.named("background")
}
