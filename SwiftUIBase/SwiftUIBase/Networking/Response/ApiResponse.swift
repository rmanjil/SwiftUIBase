//
//  ApiResponse.swift
//  PracticalAction
//
//  Created by manjil on 29/03/2023.
//

import Foundation

public struct ApiResponse<T: Decodable>: Container {
    
    var data: T?
    var errors: [ErrorMessage]?
    var meta: Meta?
    var hasData: Bool {
        return data != nil
    }
    
}

struct Response<T: Decodable> {
    var data: T
    var meta: Meta?
    var statusCode: Int 
}
