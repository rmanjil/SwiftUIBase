//
//  TokenManager.swift
//  PracticalAction
//
//  Created by manjil on 29/03/2023.
//

import Foundation


public class AuthModel: Codable {
    
    public var tokenType: String?
    public var expiresIn: Double?
    public var accessToken: String?
    public var refreshToken: String?
    public var date: Date?
    //// public var errors: [ResponseMessage]?
    //required for showing/hiding change password option
    public var isFromSocialMedia: Bool?
    
}

class TokenManager {
    var token: AuthModel? {
        set {
            if let newValue {
                KeyChainManager.standard.set(object: newValue, forKey: .authModel)
            }
        } get {
            return  KeyChainManager.standard.retrieve(type: AuthModel.self, forKey: .authModel)
        }
    }
    
    func isTokenValid() -> Bool {
        if let time = token?.expiresIn, let date = token?.date {
            let expiryDate = date.addingTimeInterval(time)
            return Date().compare(expiryDate) == ComparisonResult.orderedAscending
        }
        return false
    }
    
    var param: Parameters {
        if let token {
            return ["grantType": "refresh_token", "refreshToken": token.refreshToken ?? ""]
        }
        return [:]
    }
}
