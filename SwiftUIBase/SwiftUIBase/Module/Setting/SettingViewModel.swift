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
    case setting
    
    var title: String {
        switch self {
        case .language:
            return "Language"
        case .mode:
            return "Dark Mode"
        case .setting:
            return "Setting"
        }
    }
}

class SettingViewModel: ObservableObject {
    
    let settings  = Setting.allCases
    
}
