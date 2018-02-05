//
//  User.swift
//  PasswordStorage
//
//  Created by Joao Paulo Cavalcante dos Anjos on 1/30/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

struct User {
    
    static var logged = User()
    
    var password: String?
    var email: String?
    var token: String?
}
