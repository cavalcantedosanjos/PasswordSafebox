//
//  AccountListViewModel.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation
import RxSwift

class AccountListViewModel {
    
    // MARK: - Properties
    public var accounts = Variable<[Account]>([Account]())
    
    // MARK: - LifeCycle
    init() {
      getAccounts()
    }
    
    // MARK: -
    func getAccounts() {
        self.accounts.value = AccountManager.shared.getAccounts()
    }
    
    func deleteAccount(account: Account) {
        AccountManager.shared.deleteAccount(account)
        getAccounts()
    }
}
