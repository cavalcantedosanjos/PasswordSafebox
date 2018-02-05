//
//  UImageViewExtension.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 02/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    
    func loadImageWithAuthorization(url: String) {
        
        let url = URL(string: "https://dev.people.com.ai/mobile/api/v2/logo/\(url)")
        
        let modifier = AnyModifier { request in
            var r = request
            r.setValue(User.logged.token!, forHTTPHeaderField: "authorization")
            return r
        }

        self.kf.setImage(with: url, options: [.requestModifier(modifier)]) { (image, error, type, url) in
            if error == nil && image != nil {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "ic_image_galery")
                }
            }
        }
    }
    
}
