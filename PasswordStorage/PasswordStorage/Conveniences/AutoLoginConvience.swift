//
//  AutoLoginConvience.swift
//  PasswordStorage
//
//  Created by Joao Paulo Cavalcante dos Anjos on 2/3/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

class AutoLoginConvience {
    
    fileprivate let usernameKey = "AUTO_LOGIN_USERNAME"
    fileprivate let passwordKey = "AUTO_LOGIN_PASSWORD"
    fileprivate let autologinKey = "AUTO_LOGIN_ENABLED"
    
    var username: String {
        get {
            return UserDefaults.standard.value(forKey: usernameKey) as? String ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: usernameKey)
        }
    }
    
    var password: String {
        get {
            return UserDefaults.standard.value(forKey: passwordKey) as? String ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: passwordKey)
        }
    }
    
    var autoLoginEnable: Bool {
        get {
            return UserDefaults.standard.value(forKey: autologinKey) as? Bool ?? false
        } set {
            UserDefaults.standard.set(newValue, forKey: autologinKey)
        }
    }
    
    
    func clear() {
        self.username = ""
        self.password = ""
        self.autoLoginEnable = false
    }
}
