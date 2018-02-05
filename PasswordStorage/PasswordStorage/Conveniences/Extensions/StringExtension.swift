//
//  StringExtension.swift
//  PasswordStorage
//
//  Created by Joao Paulo Cavalcante dos Anjos on 2/1/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

extension String {
    
    func containsNumbers() -> Bool {
        let range = self.rangeOfCharacter(from: .decimalDigits)
    
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    func containsLetters() -> Bool {
        let range = self.rangeOfCharacter(from: .letters)
        
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    func containsSymbols() -> Bool {
        let characterset = CharacterSet.alphanumerics
        let range = self.rangeOfCharacter(from: characterset.inverted)
        
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    func containsUppercase() -> Bool {
        let range = self.rangeOfCharacter(from: .uppercaseLetters)
        
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
}
