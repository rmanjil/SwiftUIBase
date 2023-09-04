//
//  LanguageViewModel.swift
//  SwiftUIBase
//
//  Created by manjil on 23/08/2023.
//

import Foundation

enum Language: String, CaseIterable {
    case english
    case nepali
    
    var identifier: String {
        switch self {
        case .english:
            return ""
        case .nepali:
            return "ne_NP"
        }
    }
    
}
