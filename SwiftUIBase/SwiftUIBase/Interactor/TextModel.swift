//
//  TextModel.swift
//  ChatApp
//
//  Created by manjil on 22/02/2023.
//

import Foundation
import Combine 

public protocol  Plainable {
    var name: String { get }
}
public protocol Fieldable {
    var   pattern: String { get }
}

public protocol TextFieldInteractable {
    func isValid(value: String?) -> AppError?
    var pattern: PatternIdentifiable {get set}
}

enum PlainFieldType: Plainable {
    case email
    case password
    case firstName
    case none
    case lastName
    var name: String {
        switch self {
        case .email:
            return "email"
        case .password:
            return "password"
        case .none:
            return ""
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        }
    }
}

class TextModel: ObservableObject {
    var bag = Set<AnyCancellable>()
    
    @Published var value: String = ""
    @Published var error: Error? = nil
    
    let dataType: Plainable
    let interactor: TextFieldInteractable
    
    init(dataType: PlainFieldType, interactor: TextFieldInteractable = TextInteractor(type: PlainFieldType.none, pattern: Pattern.none, optional: false) ) {
        self.dataType = dataType
        self.interactor  = interactor
        
        $value.sink { [weak self] value in
            guard let self = self else { return }
            self.isValid(value: value)
        }.store(in: &bag)
        
    }
    
    func isValid(value: String) {
        error = interactor.isValid(value: value)
    }
}


enum TextError: Localie {
    case required(String)
    case inValid(String)
    
    var value: String {
        switch self {
        case .required(let string):
            return "Please provide \(string)."
        case .inValid(let string):
            return "Please provide valid \(string)."
        }
    }
}


