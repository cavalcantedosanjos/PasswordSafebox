//
//  Account.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

struct Account: Codable {
    
    var id: String?
    var username: String?
    var password: String?
    var url: String?
    
    static func gerateId() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "ddMMyyyHHmmss"
        return dateformatter.string(from: Date())
    }
}
