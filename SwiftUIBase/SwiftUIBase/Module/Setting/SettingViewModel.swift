//
//  SettingViewModel.swift
//  SwiftUIBase
//
//  Created by manjil on 21/08/2023.
//

import Foundation
import Combine

enum Setting: CaseIterable {
    case language
    case mode
    
    var title: String {
        switch self {
        case .language:
            return "Language"
        case .mode:
            return "Dark Mode"
        }
    }
}

class SettingViewModel: ObservableObject {
    
    let settings  = Setting.allCases
    
}
