//
//  SignInViewModel.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 31/01/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation
import RxSwift

class SignInViewModel {
    
    // MARK: - Properties
    
    public var email = Variable<String>("")
    public var password = Variable<String>("")
    public var isLoading = Variable<Bool>(false)
    
    public var serviceResponse = Variable<ServiceResponse?>(nil)
    public var errorResponse = Variable<ErrorResponse?>(nil)
    
    // MARK: - Lifecycle
    
    init() { }
    
    // MARK: - Business Logic
    
    public var isDataValid: Observable<Bool> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()) { email, password in
            return email.count > 0 && password.count > 0 
        }
    }
    
    // MARK: - Services
    func postLogin() {
        isLoading.value = true
        
        LoginServices().post(email: email.value, password: password.value, onSuccess: { (response) in
            
            User.logged = User(password: self.password.value, email: self.password.value, token: response?.token)
            self.saveAutoLogin()
            self.clearValues()
            self.serviceResponse.value = response
        }, onFailure: { (error) in
            self.errorResponse.value = error
        }, onCompleted: {
            self.isLoading.value = false
        })
    }
    
    private func saveAutoLogin() {
        let autologin = AutoLoginConvience()
        autologin.autoLoginEnable = true
        autologin.password = password.value
        autologin.username = email.value
    }
    
    private func clearValues() {
        email.value = ""
        password.value = ""
    }
    
}
