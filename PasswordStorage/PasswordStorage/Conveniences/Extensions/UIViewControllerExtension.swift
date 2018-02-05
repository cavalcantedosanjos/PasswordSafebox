//
//  UIViewControllerExtension.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 02/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func showAlert(title: String, message: String, buttonTitle: String, dissmisBlock: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: buttonTitle, style: .default) { (alertAction) in
            dissmisBlock()
        }
        
        alertController.addAction(button)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithOptions(title: String, message: String, rightButtonTitle: String, leftButtonTitle: String, rightDissmisBlock: @escaping () -> Void, leftDissmisBlock: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        let leftButton = UIAlertAction(title: leftButtonTitle, style: .default) { (alertAction) in
            leftDissmisBlock()
        }
        
        let rightButton = UIAlertAction(title: rightButtonTitle, style: .default) { (alertAction) in
            rightDissmisBlock()
        }
        
        alertController.addAction(leftButton)
        alertController.addAction(rightButton)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showToaster(message: String) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            alertController.dismiss(animated: true, completion: nil)
        }

    }

}
