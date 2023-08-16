//
//  TextInteractor.swift
//  ChatApp
//
//  Created by manjil on 22/02/2023.
//

import Foundation
// The Regular expression pattern to validate the interactor value
public enum Pattern: String, PatternIdentifiable {

    /// The password type
    case password = #"(?=^.{8,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s)[0-9a-zA-Z!@#$%^&*()-^*]*$"#

    /// The email type
    case email = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"

    /// The plain text type
    case text = "[\\s\\S]{3,}"
    
    /// The number type
    case number = "^[1-9]\\d*$"
    
    /// decimal type
    case decimal = #"^\d*\.?\d*$"#

    /// The phone number type (Australia for now)
    case phone = #"^(?:\+?(61))? ?(?:\((?=.*\)))?(0?[2-57-8])\)? ?(\d\d(?:[- ](?=\d{3})|(?!\d\d[- ]?\d[- ]))\d\d[- ]?\d[- ]?\d{3})$"#
    
    case phoneAndLandLine = #"^(\+?61)?(((1300|1800)\d{6}$)|(0?[2-57-8]\d{8}$)|(13\d{4}$))"#

    /// Austrailia Post Code Updated regex for current postcode ranges (as of 2019):
    case postCode = "^(0[289][0-9]{2})|([123456789][0-9]{3})$"
    
    case none = ""
    
    /// This method will match the regular expression with the given value
    /// - Parameter value: the value to match against
    public func isAMatch(value: String) -> Bool {
        if case .none = self { return true }
        
        guard let expression = try? NSRegularExpression(pattern: self.rawValue, options: []) else {
            assertionFailure("\(self) has illegal pattern. Please check and refactor")
            return false
        }
        let range = NSRange(location: 0, length: value.utf16.count)
        return expression.firstMatch(in: value, options: [], range: range) != nil
    }
}


class TextInteractor: TextFieldInteractable {

    var error: AppError?
    
    var pattern: PatternIdentifiable
    let type: Plainable
    let optional: Bool
    //@Published var validationError: AppError! = nil
    
    
    init(type: Plainable, pattern: PatternIdentifiable,optional: Bool = false) {
        self.type = type
        self.optional = optional
        self.pattern = pattern
    }
    
    func isValid(value: String?) -> AppError? {
        if optional && (value == nil || value == "" ) { return nil }
        var  trimmedValue = value ?? ""
        switch pattern {
        case Pattern.password:
            break
        default:
            trimmedValue  = trimmedValue.trim
        }
        let regResult = pattern.isAMatch(value: trimmedValue)
        return  buildErorResultIfAny(value: trimmedValue, regResult: regResult)
    }
    
    func emptyValue(value: String?) -> Bool {
        guard let value = value else { return true }
        return value.isEmpty
    }
    
    
    
    private func buildErorResultIfAny(value: String, regResult: Bool) -> AppError? {
        switch pattern {
        case Pattern.text, Pattern.email,  Pattern.postCode, Pattern.number, Pattern.decimal:
           return set(value: value, result: regResult)
        case Pattern.password:
          return  set(value: value, result: regResult, extra: "")
        case Pattern.none:
            return set(value: value, result: true)
        default:
            assertionFailure("TextInteractor is not capable of validating \(pattern). Please add validating case. \(#function) \(#line)")
           
        }
        
        return nil
    }
    
    
    private func set(value: String, result: Bool, extra: String = "") -> AppError? {
        if value.isEmpty {
           return AppError.requiredField(TextError.required(type.name))
        } else if !extra.isEmpty {
            return AppError.custom(extra)
        }
        else if !result {
           return AppError.requiredField(TextError.inValid(type.name))
        }
       return nil
    }
}

