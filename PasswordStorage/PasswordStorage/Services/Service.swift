//
//  Service.swift
//  PasswordStorage
//
//  Created by Joao Paulo Cavalcante dos Anjos on 1/31/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

class Service {
    
    // MARK: Shared Instance
    
    static let shared = Service()
    
    // MARK: HttpMethods
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
    }
    
    func request(method: HttpMethod, url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil,
                 onSuccess: @escaping (_ data: ServiceResponse?) -> Void,
                 onFailure: @escaping (_ error: ErrorResponse?) -> Void,
                 onCompleted: @escaping ()-> Void) {
        
        let encodeUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let request = NSMutableURLRequest(url: URL(string: encodeUrl!)!)
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers{
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch {
                onFailure(ErrorResponse(type: "service", message: "Json serialization error.", erros: nil))
                onCompleted()
            }
        }
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            guard (error == nil) else {
                onFailure(ErrorResponse(type: "service", message: "Unknown error.", erros: nil))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                
                // Deserialize Error
                if let data = data {
                    let errorResponse: ErrorResponse = JSON.decode(data: data)!
                    onFailure(errorResponse)
                } else {
                    onFailure(ErrorResponse(type: "service", message: "Unknown error.", erros: nil))
                }
                
                onCompleted()
                return
            }
            
            // Deserialize Sucess
            if let data = data {
                let serviceResponse: ServiceResponse = JSON.decode(data: data)!
                onSuccess(serviceResponse)
            }
            
            onCompleted()
            
            }.resume()
    }
    
}
