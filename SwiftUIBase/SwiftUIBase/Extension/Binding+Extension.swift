//
//  Binding+Extension.swift
//  SwiftUIBase
//
//  Created by manjil on 06/09/2023.
//

import SwiftUI

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        DispatchQueue.main.async {
            self.wrappedValue = String(self.wrappedValue.prefix(limit))
        }
        return self
        //if self.wrappedValue.count > limit {
        // DispatchQueue.main.async {
        //      self.wrappedValue String(self.wrappedValue.dropLast())
        //   }
        //  }
    }
}
