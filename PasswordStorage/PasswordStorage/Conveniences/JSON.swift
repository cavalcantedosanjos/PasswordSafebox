//
//  JSON.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import Foundation

class JSON {
    
    static func decode<ObjectType: Codable>(data: Data) -> ObjectType? {
        var object: ObjectType?
        do {
           object =  try JSONDecoder().decode(ObjectType.self, from: data)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            print(userInfo)
        }
        
        return object
    }
 
}
