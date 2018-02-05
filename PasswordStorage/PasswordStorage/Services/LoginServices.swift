//
//  LoginServices.swift
//  PasswordStorage
//
//  Created by Joao Paulo Cavalcante dos Anjos on 1/31/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

class LoginServices {
    
    func post(email: String, password: String,
              onSuccess: @escaping (_ token: ServiceResponse?) -> Void,
              onFailure: @escaping (_ error: ErrorResponse?) -> Void,
              onCompleted: @escaping ()-> Void) {
        
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        let url = "\(Environment.shared.baseUrl)/v2/login"
        
        Service.shared.request(method: .post, url: url, parameters: parameters, headers: nil, onSuccess: { (serviceResponse) in
            onSuccess(serviceResponse)
        }, onFailure: { (error) in
            onFailure(error)
        }, onCompleted: {
            onCompleted()
        })
        
    }
}
