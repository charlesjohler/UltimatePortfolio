//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Charles Johler on 17.07.21.
//


import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value>{
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
    
}
