//
//  AccountRegisterViewModel.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation
import RxSwift

class AccountRegisterViewModel {

    // MARK: - Properties
    
    public var url = Variable<String>("")
    public var username = Variable<String>("")
    public var password = Variable<String>("")
    public var account = Account()
    
    // MARK: - Lifecycle
    
    init() { }
    
    // MARK: - Business Logic
    
    public var isDataValid: Observable<Bool> {
        return Observable.combineLatest(url.asObservable(), username.asObservable(), password.asObservable()) { url, username, password in
            
            return url.count > 4 && username.count > 0 && password.count > 0
        }
    }
    
    func saveAccount() {
        let account = Account(id: Account.gerateId(), username: username.value, password: password.value, url: url.value)
        AccountManager.shared.saveAccount(account)
    }
    
    func updateAccount(account: Account) {
        var a = account
        a.password = password.value
        a.username = username.value
        a.url = url.value
        AccountManager.shared.updateAccount(a)
        self.account = a
    }
    
}
