//
//  AccountDetailViewModel.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 02/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation
import RxSwift

class AccountDetailViewModel {
    
    // MARK: - Properties
    public var accounts = Variable<[Account]>([Account]())
    
    // MARK: - LifeCycle
    init() {

    }
    
    func deleteAccount(account: Account) {
        AccountManager.shared.deleteAccount(account)
    }
}
