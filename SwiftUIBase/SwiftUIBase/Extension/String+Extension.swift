//
//  String+Extension.swift
//  ChatApp
//
//  Created by manjil on 22/02/2023.
//

import Foundation

extension String {
    var trim: String {
        self.trimmingCharacters(in: .whitespaces)
    }
    
   func validate(withPattern pattern: String) -> Bool {
         let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
         return predicate.evaluate(with: self)
     }
    
    var safeEmail: String {
        self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
    
}
