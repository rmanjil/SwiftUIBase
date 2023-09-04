//
//  UserManager.swift
//  PracticalAction
//
//  Created by Binaya Thapa Magar on 04/05/2023.
//

import Foundation

func ekParser<O: Decodable>(value: ApiResponse<O>) throws -> O {
    if let model = value.data {
        return model
    } else if let error = value.errors?.first {
        throw NetworkingError(error.detail ?? "ERROR_IS_MISSING_\(O.self)", code: error.code ?? 0)
    } else {
        throw NetworkingError("\(O.self)_MODEL_NOT_FOUND")
    }
}

class UserManager {
    
    // MARK: - Singleton
    let networking = Networking.default
    
    func login(parameters: Parameters) async throws -> AuthModel {
        
        let response = try  await networking.dataRequest(router: AuthRouter.login(parameters),
                                                         type: ApiResponse<AuthModel>.self)
        let authModel = try ekParser(value: response.data)
        KeyChainManager().set(object: authModel, forKey: .authModel)
        return authModel
    }
    
//    func fetchProfile() async throws -> User {
//
//        let response = try await networking.dataRequest(router: AuthRouter.profile,
//                                                        type: User.self)
//        DispatchQueue.main.async { [weak self] in
//            if let self {
//                self.databaseHandler.writeObjects(with: [response.data])
//            }
//        }
//        return response.data
//    }
//
    
    func forgotPasswordAPI(parameters: Parameters)  async  throws  -> Message {
        let response = try  await networking.dataRequest(router: AuthRouter.forgotPassword(parameters),
                                                         type: Message.self)
        return response.data
    }
    
    func logout()  async throws -> Message  {
        let response = try  await networking.dataRequest(router: AuthRouter.logout,
                                                         type: Message.self)
        DispatchQueue.main.async { [weak self] in
            if let self {
                //self.databaseHandler.delete(object: [AppDefault.user!])
                KeyChainManager.standard.clear()
            }
        }
        return response.data
    }
    
    
    func changePasswordAPI(parameters: Parameters)  async  throws  -> Message {
        let response = try  await networking.dataRequest(router: AuthRouter.changePassword(parameters),
                                                         type: Message.self)
        return response.data
    }
}
