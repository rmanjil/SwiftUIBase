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
    
    var title: String {
        switch self {
        case .language:
            return "Language"
        }
    }
}

class SettingViewModel: ObservableObject {
    
    let settings  = Setting.allCases
    
}
