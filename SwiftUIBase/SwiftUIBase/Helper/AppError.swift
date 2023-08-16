//
//  AppError.swift
//  ChatApp
//
//  Created by manjil on 23/02/2023.
//

import Foundation

public protocol Localie {
    var value: String { get }
}

public enum AppError: Error, LocalizedError {
    case requiredField(Localie)
    case custom (String)
    
    
    public var localizedDescription: String {
        switch self {
        case .requiredField(let error): return error.value
        case .custom(let error): return "\(error)"
        }
    }
}
