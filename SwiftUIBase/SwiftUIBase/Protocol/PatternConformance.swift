//
//  PatternConformance.swift
//  ChatApp
//
//  Created by manjil on 22/02/2023.
//

import Foundation
/// This protocol will be used fo pattern supported by app
public protocol PatternIdentifiable {
    func isAMatch(value: String) -> Bool
}

/// Protocol that needs to be conform for the type of data
public protocol PatternTypeIdentifiable {
    func localizedName() -> String
}

/// Protocol for the error in inetractor
public protocol InteractorError: LocalizedError {}

/// The interactable protocol that will be available for the interactors used for validating specific testField types
public protocol Interactable {
    
    /// Method that will validate the value from TextField
    /// - Parameter value: The value to validate
    func validate(value: String) -> InteractorError?
    
    /// Initializes a interactor with pattern and dataType
    /// - Parameters:
    ///   - pattern: the pattern to validate against
    ///   - dataType: the dataTypeOf The field
    init(pattern: PatternIdentifiable, dataType: PatternTypeIdentifiable, optional: Bool)
    
    /// The dataType of the interactor field
    var dataType: PatternTypeIdentifiable { get }
}

