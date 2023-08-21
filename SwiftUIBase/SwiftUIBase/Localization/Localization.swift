//
//  Localization.swift
//  SwiftUIBase
//
//  Created by manjil on 21/08/2023.
//

import Foundation

private protocol Localizable {
    var key: String { get }
    var value: String { get }
}

private struct Localizer {
    static func localized(key: Localizable, bundle: Bundle = .main, tableName: String = "Localizable", value: String = "", comment: String = "", param: String = "") -> String {
        let path = Bundle.main.path(forResource: "ne-NP", ofType: "lproj")
        let bundle1 = Bundle(path: path!)

        let bundleUsed =   Bundle.main.bundleIdentifier == "com.ekbana.tohnichiwapp" ?  bundle : bundle1!
        let value = String(format: NSLocalizedString(key.key, tableName: tableName, bundle: bundleUsed, value: value, comment: comment), param)
        return value
    }
}

enum LocalizedKey: Localizable {
    case appName
    
    var key: String {
        switch self {
        case .appName: return "APP_NAME"
        }
    }
    
    var value: String {
        //            switch self {
        //            case .iPadConnectWith(let para), .iPadDisconnectWith(let para), .iPadFailConnectWith(let para):
        //                return Localizer.localized(key: self, param: para)
        //            default :
        //                return  Localizer.localized(key: self)
        //            }
        Localizer.localized(key: self)
    }
}
