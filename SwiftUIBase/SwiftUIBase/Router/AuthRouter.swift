//
//  AuthRouter.swift
//  PracticalAction
//
//  Created by Binaya Thapa Magar on 04/05/2023.
//

import Foundation

enum AuthRouter: NetworkingRouter {
    
    case login(Parameters)
    case profile
    case forgotPassword(Parameters)
    case logout
    case refreshToken(Parameters)
    case changePassword(Parameters)
    
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .profile:
            return "auth/profile"
        case .forgotPassword:
            return "auth/forgot-password"
        case .logout:
            return "auth/logout"
        case .refreshToken:
            return "auth/refresh-token"
        case .changePassword:
            return "auth/change-password"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .forgotPassword, .logout, .refreshToken, .changePassword:
            return .post
        case .profile:
            return .get
        }
    }
    
    var encoder: [EncoderType] {
        switch self {
        case .login(let parameter), .forgotPassword(let parameter), .changePassword(let parameter), .refreshToken(let parameter):
            return [.json(parameter)]
        case .profile, .logout:
            return [.json(nil)]
        }
    }
}
