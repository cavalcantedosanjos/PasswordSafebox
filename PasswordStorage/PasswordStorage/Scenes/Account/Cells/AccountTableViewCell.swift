//
//  AccountTableViewCell.swift
//  PasswordStorage
//
//  Created by João Paulo dos Anjos on 01/02/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit


class AccountTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    func setup(with account:Account) {
        urlLabel.text = account.url
        userLabel.text = "Username: \(account.username!)"
        logoImageView.loadImageWithAuthorization(url: account.url!)
    }
}
