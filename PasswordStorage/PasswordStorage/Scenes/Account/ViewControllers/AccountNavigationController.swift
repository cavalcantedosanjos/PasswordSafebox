//
//  StorageNavigationController.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

class AccountNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fillColor()
    }
    
    func fillColor() {
        self.navigationBar.backgroundColor = ThemeColor.shared.primaryColor
        self.navigationBar.barTintColor = ThemeColor.shared.primaryColor
    }
}

extension AccountNavigationController {
    // MARK: - Instantiation
    static func instantiate() -> AccountNavigationController {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! AccountNavigationController
    }
}
