//
//  KeychainConvenience.swift
//  PasswordStorage
//
//  Created by Joao Paulo Cavalcante dos Anjos on 2/1/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation
import KeychainSwift

class AccountManager {
    
    private var KEYCHAIN_USER_KEY: String {
        return "STORANGE_ACCOUNTS_\(User.logged.email!)"
    }
    
    static let shared = AccountManager()
    
    func saveAccount(_ account: Account) {
        var accounts = getAccounts()
        accounts.append(account)
        saveAll(accounts)
    }
    
    func getAccounts() -> [Account] {
        
        guard let data = KeychainSwift().getData(KEYCHAIN_USER_KEY),
            let accounts = try? JSONDecoder().decode([Account].self, from: data) else {
                return [Account]()
                
        }
        
        return accounts
    }
    
    func updateAccount(_ account: Account) {
        var accounts = getAccounts()
        if  let index = accounts.index(where: {$0.id == account.id}) {
            accounts.remove(at: index)
            accounts.insert(account, at: index)
        }
        saveAll(accounts)
    }
    
    func deleteAccount(_ account: Account) {
        var accounts = getAccounts()
        if  let index = accounts.index(where: {$0.id == account.id}) {
             accounts.remove(at: index)
        }
        saveAll(accounts)
    }
    
    private func saveAll(_ accounts: [Account]) {
        let encodedData = try? JSONEncoder().encode(accounts)
        KeychainSwift().set(encodedData!, forKey: KEYCHAIN_USER_KEY)
    }
    
    
}
