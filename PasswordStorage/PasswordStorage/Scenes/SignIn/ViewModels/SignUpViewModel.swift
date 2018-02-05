//
//  SingnUpViewModel.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 31/01/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation
import RxSwift

class SignUpViewModel {
    
    // MARK: - Properties
    
    public var name = Variable<String>("")
    public var email = Variable<String>("")
    public var password = Variable<String>("")
    
    public var isValidAmountChar = Variable<Bool>(false)
    public var isValidAmountLetter = Variable<Bool>(false)
    public var isValidAmountNumber = Variable<Bool>(false)
    public var isValidAmountSpecial = Variable<Bool>(false)
    public var isValidAmountUppercaseLetter = Variable<Bool>(false)
    
    public var isLoading = Variable<Bool>(false)
    
    public var serviceResponse = Variable<ServiceResponse?>(nil)
    public var errorResponse = Variable<ErrorResponse?>(nil)
    
    private var minAmountChar = 10
    
    // MARK: - Lifecycle
    
    init() { }
    
    // MARK: - Business Logic
    
    public var isDataValid: Observable<Bool> {
        return Observable.combineLatest(name.asObservable(), email.asObservable(), password.asObservable()) { name, email, password in
            
            let minAmount = self.checkAmountChar()
            let contaisLetter = self.isContaisLetterInPassword
            let contaisNumber = self.isContaisNumberInPassword
            let contaisSymbols = self.isContaisSymbolsInPassword
            let contaisUppercase = self.isContaisUppercaseInPassword
            
            return minAmount && contaisLetter && contaisNumber && contaisSymbols && contaisUppercase && name.count > 3 && email.count > 5
            
        }
    }
    
    var isContaisNumberInPassword: Bool {
        self.isValidAmountNumber.value = self.password.value.containsNumbers()
        return self.isValidAmountNumber.value
    }
    
    var isContaisLetterInPassword: Bool {
        self.isValidAmountLetter.value = self.password.value.containsLetters()
        return self.isValidAmountLetter.value
    }
    
    var isContaisSymbolsInPassword: Bool {
        self.isValidAmountSpecial.value = self.password.value.containsSymbols()
        return self.isValidAmountSpecial.value
    }
    
    var isContaisUppercaseInPassword: Bool {
        self.isValidAmountUppercaseLetter.value = self.password.value.containsUppercase()
        return self.isValidAmountSpecial.value
    }
    
    func checkAmountChar() -> Bool {
        self.isValidAmountChar.value = self.password.value.count >= minAmountChar
        return self.isValidAmountChar.value
    }
    

    
    // MARK: - Services
    func postRegister() {

         isLoading.value = true
        
        RegisterServices().post(name: name.value, email: email.value, password: password.value, onSuccess: { (response) in
            
            User.logged = User(password: self.password.value, email: self.password.value, token: response?.token)
            self.saveAutoLogin()
            
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
    
    
}



















