//
//  ErrorResponse.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

struct ErrorResponse: Codable {
    var type: String?
    var message: String?
    var erros: [String]?
}
