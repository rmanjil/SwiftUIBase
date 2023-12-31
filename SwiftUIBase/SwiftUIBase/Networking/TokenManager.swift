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

protocol TokenManageable {
    func refreshToken() async -> Bool
    func isTokenValid() -> Bool
    var tokenParam: [String: String] {get }
    
}

class TokenManager: TokenManageable {
    
    func refreshToken() async -> Bool {
        do {
            let value = try  await Networking.default.dataRequest(router: AuthRouter.refreshToken(param), type: ApiResponse<AuthModel>.self)
            token = try ekParser(value: value.data)
            return true
        } catch {
            print(error.localizedDescription)
        }
        KeyChainManager().clear(.authModel)
        NotificationCenter.default.post(name: .tokenExpire, object: nil)
        
        return false
    }
    
    func test() async -> Bool {
        await withCheckedContinuation({ [weak self] continuation in
            guard let self else {
                continuation.resume(returning: false)
                return
            }
            let operation = OperationQueue()
            print(param)
            operation.addOperation {
                Task {
                    do {
                        let value = try  await Networking.default.dataRequest(router: AuthRouter.refreshToken(self.param), type: ApiResponse<AuthModel>.self)
                            self.token = try ekParser(value: value.data)
                        continuation.resume(returning: true)
                    } catch {
                        print(error.localizedDescription)
                    }
                    KeyChainManager().clear(.authModel)
                    NotificationCenter.default.post(name: .tokenExpire, object: nil)
                    continuation.resume(returning: false)
                }
            }
        })
    }
    
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
    
    var tokenParam: [String: String] {
        if let token =  token,
           let accessToken = token.accessToken,
           let type = token.tokenType {
          return  ["Authorization": "\(type) \(accessToken)"]
        }
        
        return [:]
    }
}


extension NSNotification.Name {
    static let tokenExpire = NSNotification.Name("TOKEN_EXPIRE")
}
